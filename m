Return-Path: <linux-kernel+bounces-301797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9E395F5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A2FB22064
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3221946C9;
	Mon, 26 Aug 2024 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9ka31GX"
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com [209.85.166.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E11946B5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687839; cv=none; b=UgZAB9uxO1+PwS74WQ8k7NGQ16w3CTmO9x4ytcLshBG9ekYhnD1IyAvueCd867kzBqwZ6HdlZ4srayAxopbcnamKCt+v6mOTU3j+I9P2fP4DaH+3LQz/hA29siDxRO6BzXpMn0xxLY8Gusd0AqwsOEgWw1/1yXwH9PV0L8hJMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687839; c=relaxed/simple;
	bh=R/FKE+Vqjw1b26cP1BW8Gn5IExiNl/9oqrudwSS6Dq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c1ty7akBncDXd15jGIjslB1L7nksGogM5bSo1xubNIFEj0tmKlZml/wAruXmfignAjzikxm1O4U9sNgcnE4VDYZYU7MRFFbY+CS3+tIrPPKMICkjzEh8IFjb2wLkJd2QZl6GMwgTs/9GYBtIQHrobztwKzIG9c+s2jVHAVLDFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9ka31GX; arc=none smtp.client-ip=209.85.166.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f195.google.com with SMTP id e9e14a558f8ab-39d2e4d73bcso18582185ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724687837; x=1725292637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yz/m+I1mEPoG8hIE0qavFnWoabah9gVgrFM3JQlh/wg=;
        b=e9ka31GXjLJJfUKzt2iSugbCxNz5eswG6AQDOhER4Mq+aEzlrJnarjTceUP+EjLRhd
         pN/1ldQEbTAzKl8bJUcTt1T3GKhLoBcjdp+7ZSsBByadSPvNf3n8QB9R+Noy9KFZow2L
         368j0RTbYoHg/Y+oYRRiSU8xQfnj7mysVl/6pzjD9gq3qC34DEh6pWOnpZUvJc+xO5Cv
         nH6Qs77v7PYufHd84ddqbN7ThKH4eW2EKwWUCadadepJ2UICAxtjV5loZ5Fw5aAJUefS
         Qnn48/SpWYdHCTH77/RZHMlk2ZY5ttIuGI4hWSo1guUqc5a7/S3nemt0Zyb+cbOUc6D3
         ugKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724687837; x=1725292637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yz/m+I1mEPoG8hIE0qavFnWoabah9gVgrFM3JQlh/wg=;
        b=Ka/15xq/c7snxRFlj7Vo1Ey6kZ4MRvTRoErBj1eIh304fG13pKAn+jQL2jNB8ei6G/
         sxEGnfVO6+yv5xa17Gx5KcPlzBfyCTXPmd062279MixtXcSfnkb5yZSGs7qo+2GqZ2Q1
         Kb7/q+yAvse0QftPumXntWQ4b+7azKRLgaqqp9FQfNGxG23lqzhmW1lcJxpQQHuy/vwI
         wuqVqdV5JUAXmuHCLH9qP9mIGTHZLJmm7GXF22bjP5rH/gViJv2Shbwz94vNeUFMjJkR
         B8jkyzTmP3A1Tjw8tryp7MoHwF0vsfhaMmkoW1ASZvWiY7Z9eFyjlpwCfndZ0MEZSXi8
         j/CQ==
X-Gm-Message-State: AOJu0Yz9aNZhXk2gwPq707BaqBbUKPGI72dsEuAnyq9uz2Yy5cCSWWup
	+LoV2UpGrZ6Bbi3D2xNkznp08WG8HbqpaYj9nRPrAaDWfe3nf64h
X-Google-Smtp-Source: AGHT+IGSbHEdxq1zL8biNt0fPcoHlObsbDOUervjyEp7CuqncfvbI/TcA1nuXzCRjZfboa84SOUEew==
X-Received: by 2002:a05:6e02:1d94:b0:39e:38f6:d00c with SMTP id e9e14a558f8ab-39e3c98f93emr126159175ab.15.1724687837311;
        Mon, 26 Aug 2024 08:57:17 -0700 (PDT)
Received: from localhost.localdomain (d179-68-123-141.evv.wideopenwest.com. [68.179.141.123])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d73e7cfc0sm33511975ab.49.2024.08.26.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 08:57:16 -0700 (PDT)
From: Alok Swaminathan <swaminathanalok@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Alok Swaminathan <swaminathanalok@gmail.com>
Subject: [PATCH] lib: glob.c: added null check for character class
Date: Mon, 26 Aug 2024 11:57:09 -0400
Message-ID: <20240826155709.12383-1-swaminathanalok@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added null check for character class. Previously, an inverted character 
class could result in a nul byte being matched and lead to the function 
reading past the end of the inputted str.

Signed-off-by: Alok Swaminathan <swaminathanalok@gmail.com>
---
 lib/glob.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/glob.c b/lib/glob.c
index 15b73f490720..aa57900d2062 100644
--- a/lib/glob.c
+++ b/lib/glob.c
@@ -68,6 +68,8 @@ bool __pure glob_match(char const *pat, char const *str)
 			back_str = --str;	/* Allow zero-length match */
 			break;
 		case '[': {	/* Character class */
+			if (c == '\0')	/* No possible match */
+				return false;
 			bool match = false, inverted = (*pat == '!');
 			char const *class = pat + inverted;
 			unsigned char a = *class++;
-- 
2.46.0


