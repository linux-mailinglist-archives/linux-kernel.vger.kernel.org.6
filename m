Return-Path: <linux-kernel+bounces-227864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12613915771
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F2A1F23ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7C11A0705;
	Mon, 24 Jun 2024 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="1TLiJhaT"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D67619FA7C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258973; cv=none; b=Ib+v1mFjCJ+L0cBxI2V/v8nh2CIvVpL1sECPQlGBrk49H3ofgsaH725wRuTBIFlzaOuWz6LQv4SSO4epXlDIvJlJjHrVj1yJDQtUeR8RiHt3ywfiJ7f7NyqFsB7R1THC5YZRLzI9LxJzyAQAyl2NeRdaQx/yXwAzQa1CBXl+Zz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258973; c=relaxed/simple;
	bh=0Ry5iW7yjh4+dkK5KfmVxe6kFHr27wLyHfv1FVt7WXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHPI/DrQ75bLEz3bM+AKDE7xTcAUCEqigj3vyK4jjcUO+UJdb3CfHjNCxi0vU22rswbWKotIRy3i/qhwfsEC27rFGTKkE/2DNl6yqLNTGeGd8I5N1JLtQW8E8VUHrp+9hDL0k8JKLR1xnVI+0NZWt4tFFKKAv5alqhc7kSIk1Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=1TLiJhaT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9aeb96b93so33995385ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719258972; x=1719863772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3tqQIIuDCADHgpFY8cfM0SAO57n+ccJALQge0Cj32Ko=;
        b=1TLiJhaTxEGzLEsso757SQ0WdBj5CFTFpJcLqshM0mSeDeAU80EcdNZ1pKw40IcNCb
         JITd02bZ5k3WDqwpSLkBADxPj9C269gNpUKRVnzZCLVZq8pUOpQfvMszXFfpHU0aQkkx
         +JdSQWnKgFxBnK8wrhPme5MC/rOzJQ23NOw6bvkCZUcmF1G0nfNQLrigXybIGGPozUp0
         lm/WvX6lNnyn17kSN26N5Svgjiw9W86+S11poTvJdVanMUPa9RAu6u4qWVb8rqORVniD
         DQGOAPcBdm7efpDk3mwNh+RrvNw+5nyL/oDzRvVbpa+45HrsXtomxfjbaV++i58e868G
         /e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719258972; x=1719863772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tqQIIuDCADHgpFY8cfM0SAO57n+ccJALQge0Cj32Ko=;
        b=qX+wHl0WyE3+f7J6NnB/wGnulrVquUqwAbJgrULV9AQNxEfIUcrdzKdsszSoJVQg9F
         GUSoWZ08+hII9Qg3q9cW7LTtcswsicWiLoq4XWuK9I76+N6wTwWym636qcacz9fTDrHS
         YiES/CnPPsrbtZIq+byzsHfddbk7HxfvxfsfGtOjkX+AoOegacWxSOnvpHVtQfjnUtfa
         ziMwy9pNSjnDSvjmbkWaAzaNlBQM1F7OzDBnazet5HeN2Xpaf2kpY8c4PywjSeLyuvTy
         Y4nUVfOrWiLmYmj+JEBHz4/y99ct1pY8zN26O+KXK6jboisXZAMScjJDabYvy8j+s/Mh
         Vwqw==
X-Forwarded-Encrypted: i=1; AJvYcCWIdAgWyp0DRPaXgYogtm4mqnnS7QxElp931WugToWwM4FZu4TULGMkjqNnmKtW69n9VAEwkxymyJy82N4odluqtOfFwfN9OriJrW55
X-Gm-Message-State: AOJu0YwPyS1E4/fVI8nlnJSp7zxjqRNeccKmdwbU1bjkJjQnjpKzq15T
	rJlc8zX/PSvzq198b5zAd/U3JWETVtn7Yg/5NODY3tfxvI8xeEj8vcmAwWuyG2t/h3Lf0QGo9LZ
	eMvw=
X-Google-Smtp-Source: AGHT+IGKGfFARVAVotDoRb++tXbqpiUnNusCVE2oSilNa9cJ0LvB+1RBjIPtkjrPvj4Lp3gTbojpBw==
X-Received: by 2002:a17:902:6548:b0:1f7:167d:e291 with SMTP id d9443c01a7336-1fa23ef7e87mr57131195ad.47.1719258971650;
        Mon, 24 Jun 2024 12:56:11 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5e63sm66161665ad.187.2024.06.24.12.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 12:56:11 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bpf, btf: Make if test explicit to fix Coccinelle error
Date: Mon, 24 Jun 2024 21:54:27 +0200
Message-ID: <20240624195426.176827-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly test the iterator variable i > 0 to fix the following
Coccinelle/coccicheck error reported by itnull.cocci:

	ERROR: iterator variable bound on line 4688 cannot be NULL

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 821063660d9f..7720f8967814 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4687,7 +4687,7 @@ static void btf_datasec_show(const struct btf *btf,
 			    __btf_name_by_offset(btf, t->name_off));
 	for_each_vsi(i, t, vsi) {
 		var = btf_type_by_id(btf, vsi->type);
-		if (i)
+		if (i > 0)
 			btf_show(show, ",");
 		btf_type_ops(var)->show(btf, var, vsi->type,
 					data + vsi->offset, bits_offset, show);
-- 
2.45.2


