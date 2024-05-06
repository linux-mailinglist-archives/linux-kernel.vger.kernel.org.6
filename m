Return-Path: <linux-kernel+bounces-169401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209FA8BC834
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF01F228E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C777E7D3F6;
	Mon,  6 May 2024 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC6ok4Sm"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AB759155;
	Mon,  6 May 2024 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979836; cv=none; b=RZPZGAAQyXzSIpkLI9/QqrgNv5anUCDFSRTJwPf8ir3eI6kj8e4rNCJg7HQ/LjNdLRoSJpaPSJwe5KlNrbenrXxba8DqgpW7Or1+KmerXPG7F4FC8fr4wGSN4ayVTZCB0oFiqn4zi6n1npL2ZxRFRQ7C56kwEAVfJCRmjJMAwV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979836; c=relaxed/simple;
	bh=K1WCsuV2vgVysMR5YZCWY9/J81gDLpA8JuqAbgG1slQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Em8SNToH1JIbWiCzLx6Q2Wwxc4HRcpSjZ8YaBVc+RufWv6xQIFHv75bY9+boYdaYleL8iUo4DMWZrZ59VnzZQ0MYfSMOKs9EnaDwN8FwSLiB+ZCKPqMH8NMsiddxitXfOajjknOzsjBIE8w3KPiVqxR/pQBPZ8FpRZZsyzmnPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC6ok4Sm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f45020ac2cso1224540b3a.0;
        Mon, 06 May 2024 00:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714979834; x=1715584634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4CZTKvqkXHwfN9qILwrzk90HvdiwAcsWOFrQEfW+iRE=;
        b=FC6ok4Sm59HZrkI+retbJ3dQQKoaemBXn7YnYqozhC50EAMhPM7xhbTwRzcp/qRNqe
         owTvB6pLPcOLvbGcb7fYQPbmuvSNMwcJ7ak/97PVr+rG7gd6v7buEASSWBhqESyskkEL
         9wYTybx7Jxxn6vZnOh9s8yrj+e+VmJK4EynabbzNjIHrJPTzoNE/IJ+GyDOpJOZ4TgBl
         Oq0qoby54BpukduCYcNmQG4uB6/0zCyxx2P33iNlWgmmKDKbnEt1hbcLTM1WEnh26Lhw
         I+CzB35PwE7B5L37URwd4351/BagAxoSz8nYVQEx1ckFbcfSkjyxINxXdfd9zMaA7H5G
         QHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714979834; x=1715584634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CZTKvqkXHwfN9qILwrzk90HvdiwAcsWOFrQEfW+iRE=;
        b=tr4+wzH3hJ3DnMIc8pMTE6rSXAFmbaERHmGBnSl1arx+gESAV3bkebhM7+50+oJEBR
         vJ/xYxe1tFraWlsVCRgV0nrnmhnE33dWQzg4/cyD8nefAhz0xaxfiw9XFGqosGcKrCWU
         Ls+Edw0xQnr/7qDRbwOr+iye+aHxmRhLkhkOgMSqBp2nG39pWz7dzfCxiMzb02y7oDwq
         R/08W2Zpjrz3xNb4sGg8q0M+BHBuvlY3MScKlisnWoey9fUmt+G1liSjFbHS+/tLGk6H
         ESQ9fJ30SqafvNC5vTeTA+oWoH025K23m1YWQaYWuLfWFYKB4lcADGIAhyC7J/3wBEbs
         3YAA==
X-Forwarded-Encrypted: i=1; AJvYcCWLgLqCFHYL8/h9gZqQ0UJNaFEloB/hhR6gaXHT/ROYDZuWk3LCHLgK9wpHf/p4ixc7Yh+KyzfFNDBJbcNIdcYHVD2FpmSa3GkIy+A0GDgoQ0sPJfzztZSZze9w3kAfrK7rGYfQngpMaD/Ct4tC2au7s/KwHxT1djVuCvjL2UzW5zC+
X-Gm-Message-State: AOJu0YzTGabEXQQ1DACSoVjtN4nvDAJM58hLdI5H5Etsk6iGd4EkBdb/
	TLhThNppBXFL/yg9gu6IObCLD2SGRDq5uGDuyrDUsVkvqBBoPwK+RqbY1g==
X-Google-Smtp-Source: AGHT+IFnkT6YBQQjfzErTQTUon6Klo1F+E+nze30gG9jbyJLQHC5uMXPftLCYlGLexdwp3QR8R3B3g==
X-Received: by 2002:a05:6a20:564e:b0:1aa:5984:d3 with SMTP id is14-20020a056a20564e00b001aa598400d3mr8611476pzc.6.1714979833990;
        Mon, 06 May 2024 00:17:13 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id u90-20020a17090a51e300b002af2bf7082fsm8178779pjh.39.2024.05.06.00.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 00:17:13 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: joe@perches.com
Cc: akpm@linux-foundation.org,
	apw@canonical.com,
	broonie@kernel.org,
	charlemagnelasse@gmail.com,
	chenhuacai@loongson.cn,
	chris@zankel.net,
	corbet@lwn.net,
	dwaipayanray1@gmail.com,
	herbert@gondor.apana.org.au,
	jcmvbkbc@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lukas.bulwahn@gmail.com,
	mac.xxn@outlook.com,
	quic_jjohnson@quicinc.com,
	sfr@canb.auug.org.au,
	v-songbaohua@oppo.com,
	workflows@vger.kernel.org
Subject: Re: [PATCH RESEND v6 2/2] scripts: checkpatch: check unused parameters for function-like macro
Date: Mon,  6 May 2024 19:16:57 +1200
Message-Id: <20240506071657.13434-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5e26f82913801050afa4442dfb9a07249895ab98.camel@perches.com>
References: <5e26f82913801050afa4442dfb9a07249895ab98.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> From: Xining Xu <mac.xxn@outlook.com>
>> 
>> If function-like macros do not utilize a parameter, it might result in a
>> build warning.  In our coding style guidelines, we advocate for utilizing
>> static inline functions to replace such macros.  This patch verifies
>> compliance with the new rule.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -6040,6 +6040,12 @@ sub process {
>>  					CHK("MACRO_ARG_PRECEDENCE",
>>  					    "Macro argument '$arg' may be better as '($arg)' to avoid precedence issues\n" . "$herectx");
>>  				}
>> +
>> +# check if this is an unused argument
>> +				if ($define_stmt !~ /\b$arg\b/) {
>> +					WARN("MACRO_ARG_UNUSED",
>> +						"Argument '$arg' is not used in function-like macro\n" . "$herectx");
> 
> trivia:  This should be aligned to the open parenthesis.
> 

Hi Joe,
I assume you mean the below?

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9895d7e38a9f..2b812210b412 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6044,7 +6044,7 @@ sub process {
 # check if this is an unused argument
 				if ($define_stmt !~ /\b$arg\b/) {
 					WARN("MACRO_ARG_UNUSED",
-						"Argument '$arg' is not used in function-like macro\n" . "$herectx");
+					     "Argument '$arg' is not used in function-like macro\n" . "$herectx");
 				}
 			}
> Otherwise:
> Acked-by: Joe Perches <joe@perches.com>

Thanks!

-Barry


