Return-Path: <linux-kernel+bounces-325929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4F4975FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF881F23611
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7B5126C0E;
	Thu, 12 Sep 2024 04:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgQFmTDR"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC337703
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726113862; cv=none; b=GszjPLomOu8Rw7AxGKfn7IxGuEMaoBO3tGYBcEfU1+bVhMlUc5rV3n58o54Q082eraiy0svniQWLkHH9eRjN5UFSxm9vhVOqD9RdI2Z2sBHayLm9sEjf+HzSSOG6fBpLc+hS7s7Udnle4mvtLtPLNyT4qMdhBnXk84axw+HfMd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726113862; c=relaxed/simple;
	bh=rvgwcp/eTAA5z5+ij//l668f8coWk03WO1JklLR9bBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MeRtl6FEau1avY09d9DvwxaAs5ROGTy+YzK4ppolQdkoAFyYohX2wz3b6CSBe2DaCgKwDg+BTUUbsYmwIqZqJyU1VL0pkrc1nyv0nBGKM1cJMYJ74HPrk45YM/wP0j3XCko64jQxls7PrF3DPgKMz+EnSB5aEU0kEN9VzXOEhbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgQFmTDR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7163489149eso476786a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 21:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726113860; x=1726718660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/cHqETZ5NjFfQQNWosTHBXQ+NEN6DfS799USGbbThKo=;
        b=OgQFmTDRqgwicIg97iLKqALzQYCLpMe51i7q/jWYuFs69noQivvPvawUtUduqx1SqJ
         Boazl0JVBQUL+X588u64/HfFWBBnvdpr3k+D1LZMorfHHqjAJ+BS52hLPxcm5Ryq4KHS
         Cqi5pOgUX1X6riahmmvrBcr2iXrG9ZLmvRZlCo8ekONIAjLndczSn+hs7ni3CP2vTLdi
         MFgoynD4Gil0N7Wn0Nt/bgbZcXbVe014VO8/FHNAktkJ644YOivMLoVBWyZraz+ch+vo
         OLoHSpo8GS4Ad4Iklo9+elnwCKLS+TwoQQMgZHr19epDL6rUqDklEIAGVXtycsZFUFyl
         pB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726113860; x=1726718660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/cHqETZ5NjFfQQNWosTHBXQ+NEN6DfS799USGbbThKo=;
        b=T9zgnWstV+ie/3n54RhQ9DuK9TmV2HlmFMa+02zsW6GcfmfbUkdUpUDqo7uFvSEqIW
         TgcdiTOvXNrVAlj9JIRvNC73RDW33f+Ra0Xkvn+YKXUMTEDTgAnNl8tua8Hlz3dbxYce
         DnF0kS57TKxeIJ1gAYzNYDg4j9iFAANBz77y25jN7Fkm+3DYxXibr65fB57YleUEG6Fs
         eStbhtS1z0JRbPB2v8ijQN3yof/ONxiTJQ7Ps62zPupH34GviM+q0qYI0FWw7eFB46YG
         mrCKqIUGTsSbxB1kC55pP4SPBC4Kt3TQnRn3cntQ/HhW39IgvRF4P4W937k9tWosHw6m
         02ww==
X-Forwarded-Encrypted: i=1; AJvYcCXLNIGH+oeodIWRpX6sAehiTeI58MZVl8fqlPVSwbNJeBNl8xv07JohwZFGUCYt9BRedl98khDSyx7nQC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMkSOGpdcd+xWJ4wIfxBAioro/bNi5QBVxXgaQE1nMXfX/bYd
	Y24JUrJbYO3s+sLd1g3gJZpNZgiw8ClwOH3v4FlmEaVyJTiy/a0fnADJi6LRQ7k=
X-Google-Smtp-Source: AGHT+IHYz9pQioarPC8/WmpETgcV4hy8gxi3dHvJMmwQmHcsnHP9LgehLn1GBtEe+0YXwyqbOM9/Yg==
X-Received: by 2002:a05:6a21:b8b:b0:1c8:92ed:7c5c with SMTP id adf61e73a8af0-1cf7620cc0cmr2196808637.35.1726113859881;
        Wed, 11 Sep 2024 21:04:19 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([2409:40c2:12a7:616d:eca9:534f:4e49:7c41])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fba469fsm768359a12.11.2024.09.11.21.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 21:04:19 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	guilherme@puida.xyz,
	philipp.g.hortmann@gmail.com,
	linux-kernel@vger.kernel.org,
	Sayyad Abid <sayyad.abid16@gmail.com>
Subject: [PATCH v2 0/8] staging: rtl8723bs: Fix coding style incosistencies in rtw_security.h
Date: Thu, 12 Sep 2024 09:34:01 +0530
Message-Id: <20240912040409.3315067-1-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series improves code readability by addressing coding style
issues in `rtw_security.h`. These changes aim to enhance the
maintainability and clarity of the codebase by ensuring compliance with
the Linux kernel's coding standards.

The coding style violations were identified using
`scripts/checkpatch.pl` on `rtw_security.h`.

### Changes in v2:
- Split the original patch into a series of 8 smaller patches, each
  addressing a distinct coding style issue as suggested by Greg's bot.
- Fixed indentation issues, placement of braces, and removal of spaces
  before tabs.
- Improved commit messages with detailed explanations for each change.

For reference, here is the `v1` submission:
https://lore.kernel.org/all/20240911133549.2664372-1-sayyad.abid16@gmail.com/


Sayyad Abid (8):
  staging: rtl8723bs: include: Fix open brace position in rtw_security.h
  staging: rtl8723bs: include: Fix indent for switch case in
    rtw_security.h
  staging: rtl8723bs: include: Fix indent for switch block in
    rtw_security.h
  staging: rtl8723bs: include: Fix use of tabs for indent in
    rtw_security.h
  staging: rtl8723bs: include: Fix indent for struct _byte_ in
    rtw_security.h
  staging: rtl8723bs: include: Fix indent for else block struct in
    rtw_security.h
  staging: rtl8723bs: include: Fix trailing */ position in
    rtw_security.h
  staging: rtl8723bs: include: Remove spaces before tabs in
    rtw_security.h

 .../staging/rtl8723bs/include/rtw_security.h  | 124 +++++++++---------
 1 file changed, 62 insertions(+), 62 deletions(-)

--
2.39.2


