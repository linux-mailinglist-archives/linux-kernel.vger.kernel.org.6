Return-Path: <linux-kernel+bounces-252971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4D8931AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FD0282EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8EC12AAFD;
	Mon, 15 Jul 2024 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TUoy4Dq8"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B26E61B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071058; cv=none; b=kpGRj2VZGUW3ZbxR9IYbyfiyd0WLlZAJnij/ruX8wt2gnhsEs6wPAxY4W6vkZU2m2j4j+rzkI6rQSK1CiNmwBm1Y+p/MG7QZNpxgLIAK9NyFcrWDU3YQ54wdddKU6/xJHXy+9tFNdBhds0OdWQDdvyzlhI+pma93CAPj+f9Ix8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071058; c=relaxed/simple;
	bh=Bsmpc0VdJCgXbGMhJy9C704JLK3m+Ax9F8TxdmjI7ZQ=;
	h=Date:Message-ID:From:To:Cc:Subject; b=pPe4wElvmFy2FL/cgUVzWuNiolfvDpWTwc44e8HnI6kMD8l1ExY8EKBs/PAJoAua7uuKSvDnTep/p/vSr/kHF0bVPo+uYCmIQPIyx0s1UA50rxt8oQ2DPLWXm5hepVvn1IX/VZ8BLG7e47q7UjU2qYiVM9gNuLPPt9fiizMm7AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TUoy4Dq8; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a05b4fa525so355500685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721071054; x=1721675854; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1SvJ95k6LtIC53lwJQ166LkSovQJo1Z3A0ATzEYqfw=;
        b=TUoy4Dq8xkX4p4Nhiq7DdKW0YcyOFQj8PrOFN5GGVlEXZAfQEusuB74DvdC5+wpHfZ
         lKdXNzmEfWOL4vBbrNGuzuV9kBiRNHiToZKwgfS9npwkk5rZIbMGyWELXsDeBo6e3d3Z
         XfKjC/bJLqF4FFjUwsTKSJJ36alnTRW6M6NXHohBfXz7ROLJcMrW38G4tqAe6dT/mNDd
         e1msXjJA4N9JHIE/DAtfhzE9yQltwYeHcJwmO6FkXTqA0dK4LFTNhhLyMljTFTRpi5fm
         4hZ1IXGCO9DCVND+StxBMmYerC7/0/3rkZRRoEVyfT7N8d6dNJo7msyLzaSgRROFbWvN
         n8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721071054; x=1721675854;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1SvJ95k6LtIC53lwJQ166LkSovQJo1Z3A0ATzEYqfw=;
        b=P2JuI8uAIpy9Zmpv6WkJGFHiPc9zr+HTPFilZfoCwq2mseHWCz+PSbx0Iet2WNfUIE
         KQuc9wupaR39c0JsrI/oKJ/Yq84fuwb++CImr5GNSXL4Qi26wNef4ADT4oW1wOD6Vgfb
         pmfFvNTWt2zIff3jWa3mr5e7X1harUTuRockuL9Uul2b/UygeOCz6JjKXLd9rCXrke8u
         Xs9nY2an/U4EqlaGoKYwDKNACaOFy8WJibi3oCP/sFYeCBmXCK7FewC9bx9LR8TK7XYA
         +G9qmWXnBHO8Q24pr852jaBBTlybuL5e0I9ZODx0dfdnGfZjGrlf1RBlLl8YeIhHSKRm
         52Yg==
X-Forwarded-Encrypted: i=1; AJvYcCW/ffZi3oIMhIlfUVFoCh2IIPRoiWvjan2JszR0/2xNABJu341TI2QZTOzdzG9qVCtUEUZVR7Q7aNppp6Hj+5qAMdApE0xOtBgse3v1
X-Gm-Message-State: AOJu0YxMnFzTdMzSrrgziMYLjyrhRGdTinJzpDj0wiuYx9gtmevU7I6n
	U3VDjQt6NaFLHUEtp/JfZnSrjXEKYE8l4Q/uO00ObqBn7Mtqb/2pK5+rw+QbQw==
X-Google-Smtp-Source: AGHT+IGSgcl6qwGZ73pFUTMRJB3d8hsYhody6VszuU8jGekmQlCOH7F40gt0W/lCmiheORwDMsVF2Q==
X-Received: by 2002:a05:620a:2684:b0:79e:e9ac:80c3 with SMTP id af79cd13be357-7a152fbccbbmr1979957285a.1.1721071054513;
        Mon, 15 Jul 2024 12:17:34 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160c6dc8dsm225327885a.110.2024.07.15.12.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 12:17:34 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:17:33 -0400
Message-ID: <4b4df5f5e3d91b9342b56ae69b3fd2be@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20240715
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

A single SELinux patch for Linux v6.11 to change the type of a
pre-processor constant to better match its use.  Please merge.

-Paul

--
The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20240715

for you to fetch changes up to e123134b39dc40af94e8aec49227ae55b5e087a8:

  selinux: Use 1UL for EBITMAP_BIT to match maps type
    (2024-07-02 11:41:05 -0400)

----------------------------------------------------------------
selinux/stable-6.11 PR 20240715

----------------------------------------------------------------
Canfeng Guo (1):
      selinux: Use 1UL for EBITMAP_BIT to match maps type

 security/selinux/ss/ebitmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
paul-moore.com

