Return-Path: <linux-kernel+bounces-558134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5DA5E217
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B831D7AA4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A92424BC09;
	Wed, 12 Mar 2025 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="VzFFFt+W"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B902451C3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798583; cv=none; b=U2tw2VPAQAnx3iIf1B276gPWhZXM276b83cqkMjcQHS21VQeQU9i5hyvVW4D98lG8HQMF5W1lUHRg4PPNNzCZ49M/2pmIJGgo3Aio6+RsDGngAo4sc7I51dSHpwDCkLMzs2Gy16dHlohAAp3cKCpnhFcKaItq/KKVdiF8mbbd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798583; c=relaxed/simple;
	bh=62b4R69fzdYFsgWE++tLyGqrH9930aSa4jMK+1iOmkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbe0ZtDO6+bVfPMACf7sQeI+rh5MZir8fp8g+PdKvpOCyNpNo8ugmpmRSG61JHp+IJkZuFALZRkeT1EwT1QRaEdBU9Q96bqAbROwldh1zty4Ms4Y47g6iXwpZ6UEJjQXvay0Xby5p1Rv/6aNcJ8Q2+mX83JcPtoMTRddUtuqOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=VzFFFt+W; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-219f8263ae0so1899795ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1741798581; x=1742403381; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=62b4R69fzdYFsgWE++tLyGqrH9930aSa4jMK+1iOmkU=;
        b=VzFFFt+Wg3blSMgnno+soRXAz3sTPDJK73cUlP6zmOKuwdvZGzusKGXvv6Y2aGtlM/
         hlDQn4R+nuCQ8q2pq0DEfGWRkXgR4ZyDVYKvf/d2OqaY+t8jA5Fi6HpcUjm54iT58L+s
         HCZHmFvgxBT60VTN+sk+Mdk9b420g8eja71OaC0t1ff5uhE9OxzJQ/DTLbtfsSyVka06
         Yt82Uc7yoMfabHPLpZPpvumDgMMiYVITyxupM0vP+fU4HMFTJMCUEm86mV1fvY7igd1Y
         nQvxM93xDrSnEe3GnYV5TNqj+7ZcOlYlYQ3aRpj5nBUqg6BiJS4LUBw0mAMNH/3GlsZo
         UW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741798581; x=1742403381;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62b4R69fzdYFsgWE++tLyGqrH9930aSa4jMK+1iOmkU=;
        b=wsQGcHz4un9MPziQoR+s/D5tYQJjytHykg4Fm4KqsT4pJT774luVEwOYM7LWPiPGa6
         Qu/HCLD0n10tFLON4y6F/l13hHmSHnpMlNmF4Wfc6xp/TfGLGYbBLrJ/Ov7de88PE5Sw
         Ipi/mDfHYra3anaIJLhKvp+E6TSlagdzKNSogpmpTwNbAoogrPiaEbq1cuIrt0r/6em8
         T2q2MjhwPicCyCoj//PYx6ZK14XZ43WQYkxnMiKuoAM9fMPO9IIF9b/sLe5xFARRhLNJ
         3nownfbImBEr9bq96nkX8UGkLjzkdZdOajWNxLifjVkzyDvYwdyqZ3WzKmiel7omLhm3
         XQOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeCqrCdaxeWIDk8GXeq37EeM1y0Eaans3MUR3XWu+gJne8/a2ZFb4Iw7Yn6dVbWlupIwHn5x6DEvqxk0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXei2Q1zz/N/sNcKn9fKqjDCk2YP4vyy0rqXwKgcRX4/qnnCgd
	cDZIZETnxj62C0j7cEOxaoQVSOcFbFgO4yHgItDxO3Biu53NB6kx2OYUxpSv2k0m6YF8G44onS7
	BV6vLZcnP2m43HIg3MteqXqT7JA0fxtZxM/EcSvu6RwpUp2QRWxZEOw==
X-Gm-Gg: ASbGncvCPbDWNuF3PNUpm+ogdJyF65wh81ENi6ZApfpvAlmyXpdmUlAyZ7Lz84VYL/K
	dND21M5jxgiwZQLpbDEvA5rZC5goYDaDu6Q3CgRe7ar+AHDy8S4e2kaN3zQ5XQYediaJyML0k1o
	sFTmhlkG3Ol8+3NlLa1CHeS9RKdA==
X-Google-Smtp-Source: AGHT+IExbQYuCNBZPP1B6JIhiHxs93ZddF8J0UMzuxxb8jPFKIoz7ExYudY6AlveYxLwfAae8aP8+F6s3SlMqWdNuD0=
X-Received: by 2002:a05:6a00:464f:b0:736:32d2:aa8e with SMTP id
 d2e1a72fcca58-736eb7d74b7mr10791497b3a.6.1741798581312; Wed, 12 Mar 2025
 09:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312111915.2970032-1-naresh.solanki@9elements.com>
 <66b24018-0b7e-42b6-ad86-d80f37538678@gmail.com> <CABqG17im5hO7xv-r16mFhJwcXyXt-6OKA_vTaRdc7kuQrdZyzA@mail.gmail.com>
 <130308e4-b9c5-4e6c-97d2-c36f9edc1f43@gmail.com>
In-Reply-To: <130308e4-b9c5-4e6c-97d2-c36f9edc1f43@gmail.com>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Wed, 12 Mar 2025 22:26:10 +0530
X-Gm-Features: AQ5f1Jri6R9xF74D0GbMUnYCMb6VPU7r_RcAo1b9iZOD2_nQLzIyU_MqECihmvY
Message-ID: <CABqG17hBviQ64jXgZ1fa5+ir37YPyK62LZvMgrSGADOxSTFo-w@mail.gmail.com>
Subject: Re: [oe] [meta-oe][PATCH] meta-openembedded: flashrom: Update to v1.4.0
To: Gyorgy Sarvari <skandigraun@gmail.com>
Cc: openembedded-devel@lists.openembedded.org, linux-kernel@vger.kernel.org, 
	"Signed-off-by: Patrick Rudolph" <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, 12 Mar 2025 at 22:09, Gyorgy Sarvari <skandigraun@gmail.com> wrote:
>
> On 12.03.25 17:03, Naresh Solanki wrote:
> > Hi Gyorgy,
> >
> > On Wed, 12 Mar 2025 at 19:47, Gyorgy Sarvari <skandigraun@gmail.com> wrote:
> >> On 12.03.25 12:19, Naresh Solanki via lists.openembedded.org wrote:
> >>> -Upstream-Status: Submitted [https://review.coreboot.org/c/flashrom/+/51960]
> >>> -Signed-off-by: Khem Raj <raj.khem@gmail.com>
> >>> -Change-Id: I55c4e8529d36f0850dd56441c3fb8602c5d889fd
> >>> +Upstream-Status: Inactive-Upstream
> >> Is that really the case? I mean it is just being updated to a new
> >> version, it doesn't look that inactive. That PR seems to be abandoned by
> >> the submitter at the first superficial sight, is this not the case?
> > Yes. its being inactive for long time.
> The last commit date in the main branch of
> https://review.coreboot.org/flashrom is "Sat Mar 1 19:19:16 2025 +1100"
> - less than 2 weeks ago, with last release just before Christmas. It's
> not as busy as Yocto, but doesn't look abandoned.
>
> Or am I looking at a wrong repo?
Your right.
I can work on flashrom 1.5.1 release. Please let me know.

Thanks,
Naresh
> >>> +
> >>> +EXTRA_OEMESON="-Dbash_completion=disabled -Dtests=disabled"
> >> Nitpick: Could you please fix the whitespaces around the equal sign?
> > Sure.
> >
> > Regards,
> > Naresh

