Return-Path: <linux-kernel+bounces-554989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22387A5A434
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE18C3A7982
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6E31DE2C6;
	Mon, 10 Mar 2025 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T9es5BKE"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168F015B971
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636725; cv=none; b=Urd/jJ/sPi8jeqFJyEZYtyk72K2nmbDTLXUBX4d0MNxmcwQcWs48k35yhKVxwaMBxV3bk3dyRxnHvswohUftMl9PiBWLZCFFLUiV2TM0SJdTiNK5iBvqYlAK6PPClXOmsRsdw6GJBRvr8J4Bn0nK9HYy3eYAYa6TUhaoiHRgUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636725; c=relaxed/simple;
	bh=BkkDL48kiKo+5qqGRWHrngtLxhgjyU+pX8OARxDkQNk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=XgE38Na/ep56qHpKsvTKWGAMRFhvr9D6WHL5ta2StGC8B7KBTTRN909XV52FgPGceQ55Kqi5lDoCiBvsUbE7hoJ9z0GguBTlodGe8DbXMKTlQO5YTpmG/sHNNORiVFj89uq97q5+JV/2TkmtA0GhMtJW4XO9VXzM2ecvh6r6lvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T9es5BKE; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47692b9d059so10599791cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741636723; x=1742241523; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6wuWmMKRARxB1Eg/CdF6hbh9IpfkyXmqRnG/h85u4Y=;
        b=T9es5BKEwpymJXt5h6/MNJNkEvScBzF2XwT8QpAEAkNcvv3FeaWrPM1gb+qxwbQLyy
         UKQQOWGBh7DKJqpBTJub3PtPNO9OVdUgCKH/YSJBAlPpRjqs+Z1IJwWg8JlY2SHvNQ/y
         ZhzeohIlFa6cwDRIyG2qoyufQAOwWly92M1AvF+neRvnOK20ApKharzMvhGi20RAf3mV
         rl1r/cRLHmfoL/utC8z/1hIElhMb3Fb7ddwVFpsJjgSVqPRxx15uovHswKw9dXYOP6WF
         lL46bgKU0aKrY25Pj1Bjyo68cx2UZ55tC4gsRpjtrtfFJzxmlxxLqQkYYmHyUHEbenPL
         BEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636723; x=1742241523;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i6wuWmMKRARxB1Eg/CdF6hbh9IpfkyXmqRnG/h85u4Y=;
        b=uRaWpsEDiYBem0K6cfDuzt8bKCgVdI8v4kakNDvcfRnU3vm/4XLQHgPeLr570588dX
         thThajBDJeS1T2YvFk7V2dZsU0rqmEzPEazP2Xp3nisKN6O2D8cY6T/dotRb0zSawnX8
         Kp1JK0Rf4mpeSMpCEBRPxTqkzA2IpNOb8MMrWePHDG2LJ9bcn3kxAjVjQRl81xaw4eXa
         rtZh7214zTWdnZSSpGPn8pcDusXn9DgTUaoD6JU0kJOdoOcBVHZmGcdgc5fdWJnM8XKt
         jbwKLuxQ+rM3b/apNT0jFQGnALj5gHjaIhIexpDqtF0yiSoD9LgmzXctof6e6pwg2Vh3
         eIXg==
X-Forwarded-Encrypted: i=1; AJvYcCXnjC2Nzgk22oOLADB/mq3gv3+K7s9z2/a8fujOjTQXxvjAfZQxSkgBG9fQiUnhQzl4OJfXxgqDQGFM5NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzssmDh/P8RuPRiUT1K5ZW8UZGOfFmctOUMH4sW2NNRwVAjg7lj
	GY+nhsEtJXLhB6E5De6apOK+w2AZkDrt4YEfMjpQRIWZk8xno+v3Q0OP/7wyFaeIJdDWwwtEOW0
	=
X-Gm-Gg: ASbGncuzx71UPlLarJMbTjbEsB0+Tjmk9bcg35QSYUAxFYMvUW+ccGZQHEhHrTE+F6c
	zjFmk0k8rPTnwOXRAuawVk9E8H/UohZy2z2R67KLqIvJONv+pVspPcbw2048nZ0fCbloJV4hXWI
	pMm4Q5kmcEd2IvxyfKhvkkDohek9A5oMoeMfPY/PKWdJJLFP2FKDzBtX2n1MeVlpae/Mnvh0Jm+
	RrV6mPaeApU0hCULuCuXB+ys1CoWy5Fbyepn5FytCMUuu808/WcJFduDVk+UwMfrM0VXGiRzbJr
	Gkv/+jlMrQmDnziW4/SabaFKGJjMS6cqpVGdZHL0SHHb0MapaTPjFb4O6L/YkbB9ke5sYvALquU
	LE+yQqVqAJE4+JQ==
X-Google-Smtp-Source: AGHT+IE15sVjFBcy+dpjt3Puf1WtPde/5nHjna93sAeAuE8+auuzNiDYrxeI+gkgjLXTbTf8g4XQqA==
X-Received: by 2002:ac8:5d52:0:b0:476:7327:383d with SMTP id d75a77b69052e-47673274363mr105538361cf.9.1741636722791;
        Mon, 10 Mar 2025 12:58:42 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476772de5absm29514021cf.66.2025.03.10.12.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:58:42 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:58:41 -0400
Message-ID: <f44bad6065bbf45c02dc7caf90ed0e7e@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250310_1216/pstg-lib:20250310_1216/pstg-pwork:20250310_1216
From: Paul Moore <paul@paul-moore.com>
To: sergeh@kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Serge Hallyn as maintainer for creds
References: <Z82Sug-XLC1r5wKE@lei>
In-Reply-To: <Z82Sug-XLC1r5wKE@lei>

On Mar  9, 2025 sergeh@kernel.org wrote:
> 
> Also add the documentation file as suggested by Günther Noack.
> 
> Signed-off-by: Serge Hallyn <sergeh@kernel.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

I adjusted the subject line to reflect that you chose the reviewer role,
but otherwise this looks good, merged into lsm/dev.  Thanks!

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68e4656c15ea..54b47bfc4abd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6141,11 +6141,13 @@ F:	drivers/hid/hid-creative-sb0540.c
>  
>  CREDENTIALS
>  M:	Paul Moore <paul@paul-moore.com>
> +R:	Serge Hallyn <sergeh@kernel.org>
>  L:	linux-security-module@vger.kernel.org
>  S:	Supported
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
>  F:	include/linux/cred.h
>  F:	kernel/cred.c
> +F:	Documentation/security/credentials.rst
>  
>  INTEL CRPS COMMON REDUNDANT PSU DRIVER
>  M:	Ninad Palsule <ninad@linux.ibm.com>
> -- 
> 2.34.1

--
paul-moore.com

