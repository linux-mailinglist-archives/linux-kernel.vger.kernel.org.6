Return-Path: <linux-kernel+bounces-387733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF99B5574
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B1F1F23FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E551A20A5F4;
	Tue, 29 Oct 2024 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhW36GSY"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58442071F6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239367; cv=none; b=MNCxkmEQok61DiS3cNzJIWlyurJCHbm2aUQBGub3erVy9uqNPlihP9whjUWYTsiqrKcHYbu+IZ8SFds83vZG2f/SxhcFk5b+su21tMsRafMXnt8cp/HjVWhKTyVt4FKHsG2Ei3o5X7yCTAAsei8pg1jfVPHOVU4ez+Ez4Q3dCTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239367; c=relaxed/simple;
	bh=3b1JYhCoogt29e1plZja81sNTk2igpY0OAj+Xq2plEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQ+pPUOLrHZXf19T6WVJ5u5MZ4TYRN16dK1UbO2z+WTIq2CCWG5Ixp/r4cckETcwRMz9W5UqaJZtasUnozcdoHjMpIRlfa+3b2+DR2LlmRfUAfwlVxh8vTdApY2TgTiV4ooHVu+G2X0vtbhtSEeq+A69mtXimvM2RrijdWLHWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhW36GSY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so4569392a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730239365; x=1730844165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lab7o1g2od5FhlATm1BQJvpKUF+pd5RGVodCqxvDriU=;
        b=RhW36GSYFC2GMfGurm++lmWn1cRPvbOPcWFrCaeg4Z/W2BxzxJRKhNm9DeKbA7dOSK
         EwNtoUcOP01m3Uj3+QNbF1YBJclCSxJxjgK97e44GUodycOQJQkLpy+T661U0XNVm3JP
         b0zPmoH1b3qRWHdAqGKE7btgVqEQCbwlX+XfV254/p6QNkaI9O06nOJTKBPG9/UXmzRy
         gQUaZ0MYJXCOwGZJOjlRJYHwYVJ1fj7wFUukOVnecCkrDlmrhI2V67bzH96UJYSSg7UK
         aRjSGraC/gm2EKcc+3Ers8Gn4Zl2PW57WmsCBWwHkD+b05dNnEikNhFt+bd6WTfZfHYK
         mJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730239365; x=1730844165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lab7o1g2od5FhlATm1BQJvpKUF+pd5RGVodCqxvDriU=;
        b=qiPVGq1rKmB+lMYNB9xvr5FEnu48N72T3+Pm5RFN8bp15z2DoPzuAfdoIzqOg203ui
         jUp0Fla3JKf1NtlRHd/b5ke5JdWiGLmsSEEd1m04IuOH4/Gl/KnB7d8ruAA+v9KlcT3Y
         fLAhp3kz5xHTXVglG0Fudo/RD0YT+5YbBC6DCY6ehQOWiOobE0BQWDF5bvBF+2yLeL1m
         /XtyrNzn8wVXM2LAfrmq4EadY320xdc/tuXax2f+3p0h9FsnB2ZHggidz9LrC+0GNzfl
         zU1+2yj/cfuBrFrYaQlALWCuZuocQ7ELSIHCGGMqqCtBNogF8MlAPeIoBu673JMjdBYq
         gb6w==
X-Forwarded-Encrypted: i=1; AJvYcCWqjB6mKruj6/5TkZf/aZwAWGsbcAeEbwRv56stRYFIYNRzMIc8tq8wLYMW+WlDANGEEcIfcbmDdrHUj/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw55axcsOnPLXhCiOFcV0NY2rW2iOiCiXOHc45MIsdMymLTfKUd
	IA4t6Md9JKMpwme6UV938LpHWRgK0c98rfnXPJtphxWjDrkOKDPR
X-Google-Smtp-Source: AGHT+IEbpwmKJX7mC2FkAJx7XhoO5M4gNCTQyCFub1H7kQU1Dhkh4yP8PQ1I6l/sO91+RQiE2V1wqA==
X-Received: by 2002:a17:90a:a110:b0:2e2:c6c2:b3d5 with SMTP id 98e67ed59e1d1-2e8f10692c1mr16332967a91.9.1730239364603;
        Tue, 29 Oct 2024 15:02:44 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:768d:7e1:4b86:da7d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbe7119sm128701a91.40.2024.10.29.15.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 15:02:43 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: dan.carpenter@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	philipp.g.hortmann@gmail.com,
	rodrigo.gobbi.7@gmail.com,
	~lkcamp/patches@lists.sr.ht
Subject: Re: staging: rtl8723bs: change remaining printk to proper api
Date: Tue, 29 Oct 2024 19:02:38 -0300
Message-Id: <20241029220238.110407-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e12bc7eb-07ed-4bec-84f7-5b178ba802c2@stanley.mountain>
References: <e12bc7eb-07ed-4bec-84f7-5b178ba802c2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Why are you pasing -DDBG_RX_SIGNAL_DISPLAY_RAW_DATA?
> ... But if there is some external document which says to enable it, and it's
> useful stuff then maybe we should keep it?

I've enabled this in an arbitrary way just to check the rtw_dump_raw_rssi_info()
because I was doing the debug replacement within the isolated code. Looking again,
I didn't find any documentation about this and the history of some files, the #ifdef 
macro is very old...from 7years ago. We can remove this for sure.

> If it's not used, just delete it?
Ok, I'll do it in a next patch too.

> ...as you've looked at the
> initialization path and it's okay as you said.
Ok, I'll send a v4.

Tks again and regards!

