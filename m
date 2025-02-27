Return-Path: <linux-kernel+bounces-537020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD4FA4871F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEA5169BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E3E1EB5DA;
	Thu, 27 Feb 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4xoVcbg"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04F1BD9D0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679109; cv=none; b=c+RJmlvCFazrPO2i4z6Zpiiv0iAb6IbnZ8cXKU/o5+D8ksKUK0woJKGXnxPux7mWH8y8myFjWOXSAxD0dzoBJJKPTpU0S+KOkImF1PuwiiuFT2nFcKHK+vp+6BtpTgUXvNVKerjubdm7HItVW6ftr8ox0rtsAaTFvBaSEb0OqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679109; c=relaxed/simple;
	bh=G0uPe1bQYN5d95vQKr7I4HNFRFMTII4scu4mntJt4OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4w6rIvD0THwPT6OxKK/dnzUsKYtbH1/NjMGFKg9q5ipY7Z8o79mwEg8KdjXEcdneuQHjySvw9V4JKkWwlsGdbYC/doekZ6iBjEv4ozmLKtYxL+35P82Vnub1xb+MDhs+bVqubUOOwiukMNFWuFOyULvLWxOF/IRfaigNiRE7jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z4xoVcbg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-439849103c8so1685e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740679106; x=1741283906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=witULyw7TtoqLetVGW1Y6LysfNxj0X5B05/dTt9izbo=;
        b=Z4xoVcbg7AhTPYw/AY8k9tx0Vf9FekvgAOkqbL6YASJObrRif0aDMXMz3sh0ZXOgDf
         yCeURyz30MBW60FXT4kI8DPxBRKsMIWXciM+/l1s//+PwWQPVCfnWymM7X+9Xh61Iefu
         Y7nMioGDHap/RSkfpVL7JnmMpueNvLbhHBPcNWIerSkVXVdJi8YatKFR+tY1IjPKLuC2
         2TZN2dOPsVv7G0ZwajTmLC8j0TXmWgqJUiPS+6gUwWKpsAAQKVDbpVAP8xjI94k3EHET
         7kOxfh/UJa0CIqEyrgEa+mUYRBiMSwDYraWlmCmXMuz22djJef2u8Moyr0qOYorenH8K
         WdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740679106; x=1741283906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=witULyw7TtoqLetVGW1Y6LysfNxj0X5B05/dTt9izbo=;
        b=J2tvAW6XhsGD79vVrpYa+cTXK1Hbg/Iwqa42htiFloxd8DVRJhowlrU80L/4+4gnuy
         BqLQLvGSCI1cbH1EC94KvAyMIrlsJ69PM2WDIddxcMKF0FP+EYEcIjw+wTIZcOjuCzGH
         3A2s7D8JJcw2z/Xg2fFQfBerCuyAqjqjgpK/dPfvI6/xtzbr7JyWxtNF2wHBTVxZxigW
         kxBFN6Aq+MDJqiR7UDh9oG1LJUIMENfyQA9D4F1Lb34SMlk4zQYdrLPbLceIBT+CF3YU
         7BMWb/zKHSDm53nEiYXzLqqdA9MzK2Nnh5F2b6I6b9rsVzzc6uWTCmA/HYnn8uhNx27m
         VMMg==
X-Forwarded-Encrypted: i=1; AJvYcCVEu2IanjJf6X/3Vnpp/IlAwLpQLLpazUCUJctX8O7NTmIMQsu6CLCjjKUxFP/yzfpsOpelre3FLCENfRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGfXF/YGsRicpee7CHT6MC18BYQO8qYNryqDWpXlAChyQ3NXg
	QqKv82dFBnFvMnEjajQJ/Q/22Qu3U0GJN7VCRHrkhZ9gSJGaiAlfSQ8pAF5rWg==
X-Gm-Gg: ASbGncvQW4QziovgRtkOgD2HLQ4Fvp7Acmc7Z9VAAiC52UZvp1yFaq3WNUNnmpXrimh
	YzQw00GHxfWmFnST3Wjf64YE6vzfNh6fVP1MFZ/KoVpLmPx8TXQSaXPwtvku2HBsIrNXEq3zs2L
	O7h4NyXWRoYp9ndGP1k63+3TvOv45f+Ao2VIB0cpoQitfUUkpSZHPj64X4O78ay+vpL0vFdIpBG
	9BNvjx+re7dXvKBF0WdLsWkk5IqGNTqOe8Va5bY+9wyd+fb89m8NNQv+Zh9Gl1IFfAhYCbi7YWh
	5JFd7cakZlimwa/NVhYAU1ylhomQ+8lJ6y8IXVGuvzLj8CP6shVRQguBkYhUymP5PSQtPg==
X-Google-Smtp-Source: AGHT+IGXNHWKRbpRDhtRxmSOQkQhsusbKI17eAfdufiuBuU7YJHxATrJHQS1X9gdlxiAiDFx96bvtA==
X-Received: by 2002:a05:600c:3ca8:b0:439:9434:1b6c with SMTP id 5b1f17b1804b1-43ba6bb74a0mr15565e9.3.1740679105829;
        Thu, 27 Feb 2025 09:58:25 -0800 (PST)
Received: from google.com (100.235.22.34.bc.googleusercontent.com. [34.22.235.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7868sm2738983f8f.24.2025.02.27.09.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 09:58:24 -0800 (PST)
Date: Thu, 27 Feb 2025 17:58:22 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: catalin.marinas@arm.com, joey.gouly@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, snehalreddy@google.com,
	suzuki.poulose@arm.com, vdonnefort@google.com, will@kernel.org,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH 2/3] KVM: arm64: Map the hypervisor FF-A buffers on ffa
 init
Message-ID: <Z8CnvkUwGKxcz2hj@google.com>
References: <20250226214853.3267057-1-sebastianene@google.com>
 <20250226214853.3267057-3-sebastianene@google.com>
 <Z8A3RLoZxVxcz3wj@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8A3RLoZxVxcz3wj@bogus>

On Thu, Feb 27, 2025 at 09:58:28AM +0000, Sudeep Holla wrote:
> On Wed, Feb 26, 2025 at 09:48:52PM +0000, Sebastian Ene wrote:
> > Map the hypervisor's buffers irrespective to the host and return
> > a linux error code from the FF-A error code on failure. Remove
> > the unmap ff-a buffers calls from the hypervisor as it will
> > never be called and move the definition of the
> > ffa_to_linux_error map in the header where it should belong to.
> > Prevent the host from using FF-A if the hypervisor could not
> > map its own buffers with Trustzone.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/ffa.c     | 46 ++++++++++++-------------------
> >  drivers/firmware/arm_ffa/driver.c | 24 ----------------
> >  include/linux/arm_ffa.h           | 24 ++++++++++++++++

Hi Sudeep,

> 
> Can you post the code movement from driver to the header as separate patch
> so that I can take it separately to avoid conflicts with the other changes
> I have. It could be just fine but I see no reason as why it can't be a
> separate change or why it needs to be bundled here.

Yes, let me do that and I will spin up a v2.

Thanks,
Sebastian

> 
> -- 
> Regards,
> Sudeep

