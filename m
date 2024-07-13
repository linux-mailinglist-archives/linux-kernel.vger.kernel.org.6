Return-Path: <linux-kernel+bounces-251617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F53930717
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 20:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BC21F2298B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 18:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A907C14039D;
	Sat, 13 Jul 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR6JIHOy"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F91B28D;
	Sat, 13 Jul 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720896835; cv=none; b=MyvamXqvgGM7A6HHIAPaRTv8OqIH7LY5bGSuqIlG5NN41Pu6l9S68kaYQmchOnDrep319jLwOlEUeMxEh5QvhOwqE6y5J1tXxJmjyrdS0V4PpOW7dFNdqSxiJ22doqiQ8u8PqPuWrIYyR/XHz4A/6gVBoOdZvQYutk7CetvYuFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720896835; c=relaxed/simple;
	bh=MAPCIDnAKoJj9Enx86W8lMyAqDzAwS4mVRe4booRC9I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bU4uIY+S18XVovvOA1R9WPUrBAvLlTJioto08wkgnt6FIArRuvF4BDNORcO5QNstHddI+txxd60xn6Gucr8i14hcRoXbBq+4lnyCOO0Siy4eamF/PFHETim/isH6qb7HK4L7OrPSqwL35CW5Tf4ok0gFCvjz8u2Q61S/2OZNA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR6JIHOy; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eea7e2b073so38395871fa.0;
        Sat, 13 Jul 2024 11:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720896831; x=1721501631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=07kIRSYZhfnTUHZwcptPPbWdw4UOJ51SFHtoh3GmK78=;
        b=IR6JIHOye6qzQr9dNfxPuRcvxuG6+rNJFcKSTUyd4dkSxCYne0xrf9LegGL8vhp2KO
         W9lUbF4Mls/p5Rjc4Fgvx1hl6YzZdSJ6WVfBS6Wy+X5UJ5b6Ui1QKoBZVwCsNR4ljJqE
         Nq/R8EG0jNwfmuDwC1foNQSMSJzvG0QqysVirGudof27qOXwWtYGdDRDx3UEJSyHRsz6
         BpNI9qeyIt1XOH/wCBqOiHCe6wSRCtZb4vCZqQTVf9TdVmOASdzS69SeRD/VG5+uKEwH
         RKhLZJnBdu+URByUtyrw4PYiCpDZspMkyzcrbzXXfSR+Xe/ioe097DGLDQnHc7CMNSfe
         U/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720896831; x=1721501631;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=07kIRSYZhfnTUHZwcptPPbWdw4UOJ51SFHtoh3GmK78=;
        b=amoCvNnhVO8dSjNP9vxUGIJbLLTJ5jxOXGxIvDX1ElioUkhZQVnmPzZsnSaMI9JstJ
         yUCbsMj+Zn2V1P0ZXIa9j5x4R1x4q/5lUEpWc+5zVBFwnRK6RFFHvY4WsaGzVTLNehSf
         Y7SLu8a3ly8Ad3abvjaAw7yaNfd56LoN1DOtjbsG/MMYszmk1rU4N8qKXRTyupZzd3Jb
         QWSMDy1n9Pnjg0ZeU4+omv3ZbRNNZ1j/JOFF1jfgD5UqmUTPO4pGFHqmwGaVCjhq4wDK
         Cvx71C2LyenpFOGidTWooF1eSxVHx3KU5Ejra5BSRAnIUg+LBYrdQjnyRnY8E69pF5MN
         C2mA==
X-Forwarded-Encrypted: i=1; AJvYcCVgLyx/BXmn7TZ7cUoG8+ewb/cBNCa8PvCkNQGypufBdCrU1uzc6ZluNd+N4Ble0asTbSdKGX1ZoKVqS3AHyvCboknehUI5F8kB3l8Z
X-Gm-Message-State: AOJu0YzXybrMwoqmAqzOliAX03hHXy25M/gPPDLw/WXlzZvC8gMC1kSV
	SFIkDcylsoxaLONb8oNFZS+Rs72XYPNi8apCySvV+Clel9uVSPtRQQr8pn14Gp2wFaaPSCnWy0Z
	NldtheBVur+0ccbmFZtdfAMAp79oG9xLa
X-Google-Smtp-Source: AGHT+IES26FJ1dV1mqfoCzLnto8Eq5AyIBOYoQHoRVtKr3dxxelL+vHYUJWE2k8Y1nK4IBUqFk2q2t04GwqnRn6my0I=
X-Received: by 2002:a2e:9d06:0:b0:2ec:5469:9d57 with SMTP id
 38308e7fff4ca-2eeb318275cmr92636421fa.41.1720896831089; Sat, 13 Jul 2024
 11:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sat, 13 Jul 2024 13:53:39 -0500
Message-ID: <CAH2r5ms7Q3p_-wPDttT+XCX9a8GvDmC5EdbV_SguK_iriWE_qA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fix
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
34afb82a3c67f869267a26f593b6f8fc6bf35905:

  Merge tag '6.10-rc6-smb3-server-fixes' of git://git.samba.org/ksmbd
(2024-07-09 08:16:18 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.10-rc7-smb3-client-fix

for you to fetch changes up to d2346e2836318a227057ed41061114cbebee5d2a:

  cifs: fix setting SecurityFlags to true (2024-07-13 09:24:27 -0500)

----------------------------------------------------------------
small cifs SecurityFlags fix, also for stable

----------------------------------------------------------------
Steve French (1):
      cifs: fix setting SecurityFlags to true

 Documentation/admin-guide/cifs/usage.rst | 36
+++++++++++-------------------------
 fs/smb/client/cifsglob.h                 |  4 ++--
 2 files changed, 13 insertions(+), 27 deletions(-)

-- 
Thanks,

Steve

