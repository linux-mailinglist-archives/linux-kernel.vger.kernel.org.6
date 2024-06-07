Return-Path: <linux-kernel+bounces-206494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 716A4900A8D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BF11F2434D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE5319B3E1;
	Fri,  7 Jun 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpxuIGBk"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB12B19A2A9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717778037; cv=none; b=TlfMrOCcjigonRpuEub4MMaYp6Wn8Z/kCcnDM/KQBAyzWb68pzovjBBVuD5c1aiw1gsrxQJhAFBf2u/bUE7VQDudzpgnuTddxdVeiZUlBP4KLiRXR78oZ4im515O6E3pf10SuDoZMCdYf62DhKXnvdPVWPY4EdF8f+h2HcNIm5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717778037; c=relaxed/simple;
	bh=hpqtB7TwtNEw7I0Oo+om2IRl2mZx/RvnFsItv/asbMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DOq221M+p1iqm5qPiiGCjJLZ3ZMPTAJlHKh9DS/fDYXaby63rmwnZk0GXG3jmJ4hkR3VVSdi0hyF7YOqhD2N2jDjHZiWnsImioCUukhJ/WsRUFkzKmIxGhycP2PLMKfgJVoyG65WUdcOTsgbCCecL0OYZMByCcwBeOG7fTEJCkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpxuIGBk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a52dfd081so2803632a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717778034; x=1718382834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2V8454kYmhOLRa5CXXOXDL36kSfmPqZMgZ9QCsrOhe4=;
        b=GpxuIGBkZveDFKqIDh7wljYR7DFNjizJd6fMvQ2plUEyMrwg9ctO+TnrNW2h2DTcrb
         DuX3YT4nAblTUVZflBpx2u0T+Tm0G4ESZO1QXXQ4xmYD2Me8gN4Z5eJ4fVDQDY/NJRqz
         CjPAjycRr/kXdlbNYfq5g8XYR1hhNJDhyzmZzTDp0cmbeXRaZdq/SY/5BmoDgT27n0Tv
         WL1tnBiIvLR1OA7wA9aopeqL5oAqHJ+FIPSishVJ1XUCBy0BrEH2I61Bg+wzm2jPqIoO
         R//+rJFssxBL/OpI1o0EWzVmFQ4CcvjaZPP4SXSdvgwoGAttcUcYPfRRXv6eA5sDDs9R
         M62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717778034; x=1718382834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2V8454kYmhOLRa5CXXOXDL36kSfmPqZMgZ9QCsrOhe4=;
        b=FGsHmXjQsbHF/VVd3uoOzltYnLiMBtylG+WD2zoF0hKooQKQ2iQrQA4JdSIESdx5iY
         3Oz0wxsXbpf06R8N6AAjGn20jWsp7zA5F6f8ryUYBOCSzd1vp33vpewLT+sovsfwWjxw
         hwAPjwbF6QNb1zRv0rI3vUPZ5V4n3v1CCPI9XjwbCTEyH2shVsb1B/rsR5TwGM3UEPHv
         wM76Fuxt48bEBn8vSSz06jSL5E68xN7C4MSRyefIBspEGYU1EFMgERB4FsFi1jvE2y9t
         IV+PyEuaYSpi9QR01/Wfc4afQrMv+O8qeOPfKR/O8A6qiMga4i8jMUNtKRMlMVsZAnzx
         mRwA==
X-Forwarded-Encrypted: i=1; AJvYcCWM4fMnL9t9QzWIgDOqBLEGB1XIxDRrBki1RhqV9wRmAi12YJnemrCylCP4PTzhyD5SBM66V6L8E1kJdTZV3c0FnGqzroTmW/24YGda
X-Gm-Message-State: AOJu0YxzmavLWyGzrZbbcrfUSuCTcuJTaOMW2UDcKkTlKlqRg90g80z/
	KT6RS8lJ+/nj9NCcRSCEAxsRnNh5OCHd5MI2U2RkirwoEgaURQCS
X-Google-Smtp-Source: AGHT+IGIcig7PECSJi+Qz8Gwa/+FRLovxwp17awCKsIo1kQUlOR0w+eFmFrHd/F90OlirCR/eWuaXQ==
X-Received: by 2002:a50:9314:0:b0:57c:5f8a:26f8 with SMTP id 4fb4d7f45d1cf-57c5f8a27aemr1025758a12.27.1717778033761;
        Fri, 07 Jun 2024 09:33:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ac9:e686:17a2:25c2:1b0c:3c07])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0cc355sm3032715a12.33.2024.06.07.09.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:33:53 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	sudeep.holla@arm.com
Cc: vincenzo.mezzela@gmail.com,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH 0/2 v4 RESEND] drivers: arch_topology: introduce automatic cleanup feature
Date: Fri,  7 Jun 2024 18:33:48 +0200
Message-Id: <20240607163350.392971-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
I am resending this patch series rebased on top of -rc2 as the old one [1] might 
have got lost deep in the mailbox.

This patch series introduces the automatic cleanup feature using the __free
attribute. With this modification, resources allocated with __free are 
automatically released at the end of the scope.

In some cases, modifying the structure of loops is necessary to utilize the
__free attribute effectively. For example:

```
struct device_node *t;

do {
    t = of_get_child_by_name(..);
    if (t) {
        
        // some code here

        of_node_put(t);
    }
    i++;

} while (t);

//       ^
//       |
//  device_node here
```

To use the __free attribute here, we need to move the declaration of the device_node
within the loop, otherwise the automatic cleanup is called only at the end of the
function, and not at end of each iteration of the loop, being it scope-based. 

However, moving the declaration of the device_node within the loop, we can no
longer check the exit condition in the loop statement, being it outside
the loop's scope.

Therefore, this work is split into two patches. The first patch moves the exit
condition of the loop directly within the loop's scope with an explicit break
statement:

```
struct device_node *t;

do {
    t = of_get_child_by_name(..);
    if (!t)
        break;

    // some code here

    of_node_put(t);
    i++;

} while (1);
```
The second patch eliminates all of_node_put() calls, introducing the __free 
attribute to the device_node.


changes in v2:
    - check loop exit condition within the loop
    - add cleanup.h header

changes in v3:
    - split patch in two
    - fix misalignment
    - fix checkpatch warnings
    - replace break with return statement where possible

changes in v4:
    - fix commit subject
    - fix coding style 

- [1] https://lore.kernel.org/all/Zl2CjZ9mCpK1ylMf@bogus/

Vincenzo Mezzela (2):
  drivers: arch_topology: Refactor do-while loops
  drivers: arch_topology: use __free attribute instead of of_node_put()

 drivers/base/arch_topology.c | 145 +++++++++++++++++------------------
 1 file changed, 72 insertions(+), 73 deletions(-)

-- 
2.34.1


