Return-Path: <linux-kernel+bounces-510787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2944FA321F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEA93A52DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE232063C4;
	Wed, 12 Feb 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5x8CC1O"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D192063D3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352183; cv=none; b=E6NlnzC0p76kHXlqQF0UTNeFyZe0JrelOMaE5wBC2WtOgvba7ZlzQLDh9VP5dUpimrPy+0oe6GsyNpkSLGkphXtsyik/dpv/An4i3Nz/2NHo7qgTANlKm9f5ZsCTcdvqRBJgvARblf7iY3GGjC/EXP/GNtmRtGLntB2n0d7GR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352183; c=relaxed/simple;
	bh=zQgtlrGgU2i403MDcE/W3UsKyOZHuds3X4vIFaE7F+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLuonTqBebaU+obRlzRcnt6g9B+w/1b40pYjdQRNXUsB+ivGd8wdkNVcPsEZm/b8htvvMbV5Qzw9I/7OXz/ADkDshcXfAJXNPrLkrc4O9C4C2/9c9fDBllhwt+1Hqjd19XVKCbCupeJRgxtqqoiy0vmw9on3aNX3MXy2HIHVHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5x8CC1O; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220bfdfb3f4so9295315ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739352181; x=1739956981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKlIbv0ydKkFArCDNqMZeYZ6rB/W8yZFPWOF9LQ+RT4=;
        b=f5x8CC1O3Q3J1Xu8UI1O3XxBft2T34S2y8RSPkQidq1zjlZLN8eEs9W6fodEjMJbjw
         SWsd3Q3LsEm3LzsoL81PJVpmpXzo5tpqhR9HK7bV5dxYEqJSOUH3aMrKC2aj3aAo1F+c
         Qgn86/DfOjkYswU9PQO/a4l5tRAZ1jvP4cdEK5XjslVQ/WO6Bt+2A8G1+bih+nS7ySHw
         0WH7mij2ESh96ecxjzrQJ/GI0deblYja05Y/AiIiIkE80RzXNxHeyv8Q/Jd2pAzrNISx
         3OmV6KWUT3hn6ow4tr2hwLe4Qictp/mAPGF2DrUSjIb2FkB2N6+3Etao9E1X3l6wMahM
         ztfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739352181; x=1739956981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKlIbv0ydKkFArCDNqMZeYZ6rB/W8yZFPWOF9LQ+RT4=;
        b=ITf5ei/ea+S3ZSjcfmdWCBVwczPk9CNLpNlmqmULgsbZmnSLDUnBg09X01yfb9gqEN
         pX/lZ7T/a4OmkdJSkhdlxq5PE6aYR/FIa06bgMLT3lBZigAR71X5kNQb35wJhaHJr4tl
         f++bR5zFrkSMnEsadkpSf4Ot1gjDyAamxPotHMKDyAIqtlp/GaiZ0+7yj4wT4QXxR8Oh
         MKcUETyjNW0O/3Vu9advrbomE3lZueExAovQ//Y3BZXDg8jHHVAafFcsu/qJjCHsSiy9
         FcLX/B4gNg7tIPqAInthhKEDUr5Gq+2TeqGnXgXmFJqIGUYFfKGOHib8Vgsx2Nz+/9DI
         a0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVatumbJ6MQ7Vqa1eK3W2QhM+Y/I+M0kjwsRS4ASrma7/rUWdPRZNXgPy+JQf1NWT/62ONbB8X2yk1XMxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywco31OpvkZAFeO2q+UoXvJBWXEhfke5m/FGaNEbQtS9Sk4423H
	tML3ALbTE3YnTE0zM9J/mMX2hLiEhDIAfNKl9B0MJurpqt8L3xw4
X-Gm-Gg: ASbGncs2MC7g0MjotERZG6zagSrCvaI7vMJGzlVrL4oEGmbAiWb3osBTn9XsD40aAgj
	CcfQNEV1h0+EnRK9+AW7PgfXxCWc8047ARggY7Pr9XHo5ntEgrfeGTfMuon7scr8l+a0qdx75e5
	t7JFuFxMxD2MweaRzwkmCQtDTaGPQ4xySLEr7GY5hXiAiOsTTW3BBgKIPqURpgOzv+5IEbY2zE/
	yMTbWoe2T46rMEc4fHE2ONhtQseuhWxrK4Kd3jIj7dA1QmOD67qlHdvMkBN8KLXvxHwS1AcUyQw
	2pVEYg6XYW6N+yL3nhJaZwztVbKSLdWTpcAjQJ1H/X7eliNvW9Nxmz0zG46N0sFc5CUtPYxp7WS
	5
X-Google-Smtp-Source: AGHT+IE5oLYTMyFHny3/RYjVJxsAC85hBSzY2pJoFOwuIMqob2VPFNiq2o/BVLmGBBQ01OeCii55nQ==
X-Received: by 2002:a05:6a00:1d9a:b0:732:1f45:fcca with SMTP id d2e1a72fcca58-7322c411718mr4580354b3a.21.1739352181265;
        Wed, 12 Feb 2025 01:23:01 -0800 (PST)
Received: from DESKTOP-GL3U3CJ (162-207-94-177.lightspeed.irvnca.sbcglobal.net. [162.207.94.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7307e29bd5csm6550442b3a.26.2025.02.12.01.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:23:00 -0800 (PST)
From: Ian To <onlyian4981@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ian To <onlyian4981@gmail.com>
Subject: [PATCH v2 0/3] Adhere to coding style
Date: Wed, 12 Feb 2025 01:22:53 -0800
Message-ID: <cover.1739351267.git.onlyian4981@gmail.com>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Edit the file to adhere to the kernel coding style. Reported by
checkpatch.

v2 changes: Fix some edits put in the wrong patch, thanks to Dan's keen
eyes.

Ian To (3):
  staging: rtl8723bs: format comments
  stagin: rtl8723bs: fix spacing
  staging: rtl8723bs: remove extra blank lines

 drivers/staging/rtl8723bs/core/rtw_security.c | 279 +++++++++---------
 1 file changed, 133 insertions(+), 146 deletions(-)

-- 
2.45.3


