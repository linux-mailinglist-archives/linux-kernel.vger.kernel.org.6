Return-Path: <linux-kernel+bounces-517117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1F3A37C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7A017194D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F0A1A5BA2;
	Mon, 17 Feb 2025 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAIbeN7y"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29019C553
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777618; cv=none; b=LCtW6o+cRszrLqKqHM0tWakUYpDgtu6TuPG08HloTzRSyaok15zJvDFmDniD5JmDsQuYa6q3poyMYtABLyHKTkMrlXXUTnj7vi2c971pgc8MEQuYKgumwK1UyI7vhhXjZYR/BthlLURx8taPZerrc1Q9lCMg4k/ZeS6wwDotRbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777618; c=relaxed/simple;
	bh=zcM0c0V1GS3TZJGed3LcwXT+koAZctVBP1JWt1wC7bs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G6u48Dc656R6matR9VISJbdaBooraRuO6z1+J9hc4TAmF6brdxBH3VpXSfBxaywTx8GO5sEGVX6wKbFnqFXYTi0uO9SdSj0+q2VpBtuZNOTh9ZvlUdQ2M6s5HR47yqlCpga364SSb0+XpWc0/e29ITQBFO4SeXRVuIwIznaeWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DAIbeN7y; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so509638466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739777615; x=1740382415; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4LcgUMXB/Wz2DoEL+bbrP94KZi1QyVcM8jrNwIU/TI=;
        b=DAIbeN7yi3FYa7O7TITI1BtUZEFdMsSqQR7IT8S3AuisRtxSU6zkig4Rh9LsplObPi
         fsJ8qNAltGfR0KqX0P56PX8aBqBh17uhah8GcPd3JSuLVvbRnBaG/CMsHFTUYThZAtGj
         kWEjb0FTaqcUBd8nEHSEck3dP8ZpMU+gPrEoFinQWt5Vnx8mn6f+1rB5O+Zv9g7jLDlD
         Y+EzHiOqBU2eQ+SMl8S7jBAUyBK6rfPAcC96G90bvh+Yy/Yy0aWc8yqTOwVMIMEP9yjx
         neKrFb3d5+nGNBG2CReMURnD0w2BPWmVG00dDbc5ZG0MVm96ur2NcmAUWXSny6QCQs4v
         9WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739777615; x=1740382415;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4LcgUMXB/Wz2DoEL+bbrP94KZi1QyVcM8jrNwIU/TI=;
        b=mlA1+GJHmWLE6SLtRQzTyosCZ/T6SyI3w9SZQzhzdlMfwF5OqfNXg81kEkWddmYpuF
         GefA0j2edxYT0KYYn4QzqZ0j+cO97c4+sBSpnLEfcYg2aV+mLWTo/LhDcIxJBHd3iD0G
         EWvYax2pmB3C+rUxolu7GsdmkQWKIsWVI7Lv/KvoE3j/6UfDnDYlYss7KF+klkX+Gf3o
         vnVKEmYJQoAEy6O+Fxf6DKqJTeeeo9fQbvJor+v2gvu4XV/ELAAZtHZy2V4PcD+yys+D
         3jg3dW/J2z6TvP0+UwPO9D+QUavU/Wj41+bfgUuWpVN4lp00DPTgqJUpn2qBadsY64r7
         Qkew==
X-Forwarded-Encrypted: i=1; AJvYcCWICVOrsafomyu/EyVe/1GPSa0GEqNSGzRU9RgpKFSx3gmcQJuou1JgKoEhXyhudckbZHZqTcKl4TO9Mgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoDg34ul6AHG8ySOZwK4tiSb6b90t1bHjZokTGytHzeWyetRXG
	XDfhuzzX+UdHOSfDgVWAsxkGoM8qA5cwN5Wa1VIzh/Zz5B1vHsz6N2e0cTHR2sg=
X-Gm-Gg: ASbGnctBDevvSfvuaOdgD/Vt1HfMrfvIOPvXz7A/+C9uW807aO6ftsYTyv0qernFlUt
	hHoxUuah+4LNihlJiFZ1+KwOkROd19r55Z9/t0m8nsBfbhl+AEHP9ylQNKubdFV6feAmye+ul23
	5ifvUp24k3cKhQRzVdJ+rDjh8NGfh5vQhRJ6GBxTA4ZCpC6xf1khmJZTkmKEQ/tpjmWrwsIKqJT
	449Uwf0kOyR1DkYxTkb86qvC4kTl5xQeFWlkhlBluAb2/NS1XsTpP4QUb202uEk0GncJFXBmi/j
	g4Ws4YarJPENQNhKoKO9
X-Google-Smtp-Source: AGHT+IF7SQDPhS34NSoyAyl0oz3XF6hgO/dLFCbg4PL3cGhqcXdyTG7Koy72X0FHVW9/sFD79dcHNA==
X-Received: by 2002:a17:907:9802:b0:ab7:bcc0:9067 with SMTP id a640c23a62f3a-abb70dd72f8mr973363966b.40.1739777615128;
        Sun, 16 Feb 2025 23:33:35 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abba9657249sm41281166b.38.2025.02.16.23.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 23:33:34 -0800 (PST)
Date: Mon, 17 Feb 2025 10:33:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] nfsd: Fix a WARN_ONCE() message
Message-ID: <39691ae0-124e-48ea-8a1a-1a7f26423236@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The first parameter of WARN_ONCE() is supposed to be the condition but
it's missing here.  This WARN_ONCE() will only print the "xcl_name".

Fixes: 61b490d48618 ("nfsd: fix management of listener transports")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/nfsd/nfsctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 2cd540b26965..ac265d6fde35 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2027,7 +2027,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		xprt = svc_find_listener(serv, xcl_name, net, sa);
 		if (xprt) {
 			if (delete)
-				WARN_ONCE("Transport type=%s already exists\n",
+				WARN_ONCE(1, "Transport type=%s already exists\n",
 					  xcl_name);
 			svc_xprt_put(xprt);
 			continue;
-- 
2.47.2


