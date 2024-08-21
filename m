Return-Path: <linux-kernel+bounces-296033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DEE95A4A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A9E1F23806
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FA31B3B0D;
	Wed, 21 Aug 2024 18:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vvc9Hz/k"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96CA16B725
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 18:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724264535; cv=none; b=CP083P2E5+lQQOMOgDyu03sPNJqIg0vc1ldH7QLwolnnL/3zTmtIWa8t6O+ClIpyf/5eXPCJ1kl8pY0KJD5wjwNMBJQOlJNC7Y/ESJe3+dY/2IhvoWpzvqDUKsbuA9JgTNIWdpuLjR7hvJ9jV6AV4gFbhPtVBZzOyXFq9ufmk+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724264535; c=relaxed/simple;
	bh=ofGjdtVJIZiLjPOgz/4RTi3L+cafvhVR0TZSBt+kSRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FloydCPu3UNRv91hj5SHXDJ43N4uAqJ02Ip8UjbZxcg4wtDlmeCcCyxTzGYtUEnWJTviIxJzEhE2cWttN0xvqrrKjtTeleyE5j8FDP5fzocDaRy/+coCqdrv4+zk34tyBRTMxyHS3QNyv2TkeRO44rXpiFwvzy6SoZV6JQ+X0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vvc9Hz/k; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3718eaf4046so4659484f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724264532; x=1724869332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+EvylzRgMqclEVa6Y9nb3nnjZ20K0PzDm50IGhF7Wk=;
        b=Vvc9Hz/k9UtAGiHZiS055qg2+hNboVi1TOFbbd2O6MxK9R+Iuy21Slh3AvZrRgoNbu
         SfoUWVN5uK9PxzHMpn0ew/sA2dujiVK+tEvWNDxKB6pVRSwNRuK1OnrDfEoGk0bWuIkA
         6mJd/BSDZipxGVDL28PFGwsma+9Ru1MH933cEwNEHk2DwiNTCAD7ss3UkEZWDD3Crxwh
         /7iufV1oi4f7fgmklQsF9+b/HKMEPH0xTxuakfiMRBV6Q1ZZSMGDfQtWN5Id2Zn9tIur
         wuTNyZIS7VuhG1KCqy5HQDsMc+vR3UYILDZA/+uaPFyKmX3SE7W4jCe1pegP/WSBOFbD
         ZMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724264532; x=1724869332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+EvylzRgMqclEVa6Y9nb3nnjZ20K0PzDm50IGhF7Wk=;
        b=sPW0lMrRBLM2PfVeh3Ydww9dX3Mkw8MVh2gT/D/uTsKc09NJm3ZK1R9H5mxlQT8TC4
         Q1WgAgRUfX3rUDgo7jzvQYRHiD6kVaMyyoaS84heG4rwq/kBZ8YqeRoY0qyVqVtGqKqd
         CHLho5ASWuxF6aneJFCL6ndj+Y9z1eqJmP1qknmHxFoBHgLIsHaOHtqNb6GIKqEBljkq
         1ACdMRdK2wQ4wU+6a+2TPSQPn2WO3Iu2rL4yiPzvUHQPvfVUnjWlRqttt+DzbsfIj32M
         9UvNktrHwgHq4Z57xUf7us3XnuUrZaSCd/2MsDaACSq1+ahzrVrPFVtaSs3cSM1XR0i+
         hrFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj0M3KUSwcti7jGjbovrXMBsQzI/ESNjFX2p0nTDHxXDcRtMkzdWPfjnOG11HrtbwL+djF+tmZobLOrCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6E3L2EZwCm3n+DtDKjGahsOBl6SNI/1GGbEorm6CdEG4dOB9v
	6HqTEtRk43IyKHQdhKQZaDOgUcYtyCgvNf6i11MxX4fiEY4xIg/4aFAf9jmNFbI=
X-Google-Smtp-Source: AGHT+IELVgS+H+Ie8TqF+vxzlIUfCOLU9x9LxN780T8l/WKjQpgTUUuHrTucFYyTW7d/n2qVFXgmLg==
X-Received: by 2002:a5d:598b:0:b0:371:869b:4e5e with SMTP id ffacd0b85a97d-372fd57f409mr2961406f8f.1.1724264531988;
        Wed, 21 Aug 2024 11:22:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65f2sm932819566b.29.2024.08.21.11.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:22:11 -0700 (PDT)
Date: Wed, 21 Aug 2024 21:22:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: gregkh@linuxfoundation.org, tdavies@darkphysics.net,
	philipp.g.hortmann@gmail.com, garyrookard@fastmail.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Replace strcpy with strscpy in
 rtl819x_translate_scan
Message-ID: <5ddb4b56-f78f-4219-8524-cdb2afb3e373@stanley.mountain>
References: <20240820184216.45390-1-abhishektamboli9@gmail.com>
 <b2efc687-07bd-462a-b0a5-58e09bde32a7@stanley.mountain>
 <ZsYoYe+8k0YEyS2U@embed-PC.myguest.virtualbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsYoYe+8k0YEyS2U@embed-PC.myguest.virtualbox.org>

On Wed, Aug 21, 2024 at 11:18:17PM +0530, Abhishek Tamboli wrote:
> 
> Given this, would it be better to use strcat?
> This would eliminate the need for the pname pointer and align with 
> the current code's method of concatenating the rtllib_modes.

We can't ack the patch until we see it.  Try it out and see if it looks good to
you.

regards,
dan carpenter

