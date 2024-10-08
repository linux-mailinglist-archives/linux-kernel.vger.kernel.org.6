Return-Path: <linux-kernel+bounces-354351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2049993C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799AE284C6F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 01:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738617BD9;
	Tue,  8 Oct 2024 01:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D82EfXVl"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064B1CD02;
	Tue,  8 Oct 2024 01:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728351824; cv=none; b=tGlcmZPzDbKkOmTo0Ugg4skSCT9O+eCxGrRooHvzrpGV4bWprlFmDKTd5pBZqwvsm/93XsZ+NmNf8zZFk1limaWtbuxYqqxyszyh5iZEnVHBcSomoLiQjJxJxzEgbIQZRw9KA8Lxne2EoQteNmwzBfuQkRheOGABRBgv/vdtQHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728351824; c=relaxed/simple;
	bh=yb5EjhqmUwdystXBeXZ20Rj7RIhYJNgRTV7czWOhdKc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=c8G1IngFcsXpRcjkzwPZ/gmrzUxn9Q2/9sVi/Q9lwaONHb+R7aAn3vT9aRNbqvtaRaWkqR+uCU0NMHpW8uc6+SfozuP8P9vWwtuHmgOIfIvqiA+JP1GYtvL/0pL/FFzmEA7Bar3eHBM7If8HPUDhoJI9Cb1JbgxR1QsJSB3Iugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D82EfXVl; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2689e7a941fso2606001fac.3;
        Mon, 07 Oct 2024 18:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728351822; x=1728956622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jhudap/e3GFJwj1GIVucRxNplIWeVCeDgboG8FiJJq8=;
        b=D82EfXVliWq9Qq5YxJMAd4J0Y2zKhnzh4XnjoHZwCvofe16jLDNkpJjUlilwP/EQaE
         tJxSumsVnx/FCnPCbViQy1UzJCyBMD/ShZP5305/cJG8Sl1Fo/14c4GAxvdhzKxIebiK
         Xxa5ocs1J1rYF+Px+umMAdnQsKWpvkpfQ6fkFDm4v/AiKuWlBOUW4uMRwJlC+dhrmjwB
         Lr5KdMU4S6lLCISJetOsPOA2a0z/dxhgJTPfmJ+1ccNJE9kAmb4OcEzhWUBPrSL+qDC8
         qZ3lZIXQVmz6BYvUTZpOy2z8ZWaKekjwOTQ/sDSjgzOtfndC4saAG+S+QqeKJnl1281D
         p6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728351822; x=1728956622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhudap/e3GFJwj1GIVucRxNplIWeVCeDgboG8FiJJq8=;
        b=T+UUA2Zu8HiejJ31C3ZAUcavO2lWeYosOFy6XgdUfv13jWrNfIVdld3191Wr/xkCoL
         pqf4SDTIz3rxP+5jJYf20BS2QsOTvpcO9gp9mMOSz+35NbOBlsA7ZIpJRY2vgDG1gvF1
         S4QrZKJhydUHL7t06LmnPBv1FKbRqOdxm+MvdFNM8yezzHJjedeH0nU00w0cwI3JzQ0V
         hkjMvlUQcdG34Ingoyo8AzGHU17BMyU5nqS9jiybfUprll+KVvN7L2voGsupkCUP4W7y
         VVjvt4AYLEDQZJ9ZWJk6Yj2avWohGPpfanuiEhZInXgd0nungzAdwuW/y8hjWzhkjm4s
         9JXg==
X-Forwarded-Encrypted: i=1; AJvYcCVsqb0FgOeF1y8n5ukrMSt3NvWLia8MzR+01WTDbg73ZnmN2bV6yh8EOUATfSMj/Kuxgm6nMvE0O6ys@vger.kernel.org, AJvYcCXSlh0VfblmueXL8ciiBG16Pn4fk1v0joXZQN86KuY4mDxbQjdrEi274ROwKZ3Un80Q5x9pHfteb3YZeH5X@vger.kernel.org
X-Gm-Message-State: AOJu0YypIVMnUbEfmzi6iOb0jZgmO9UfxbES0h0g10AJOKim5gblB+kE
	wceXYCP2Z6GqSw93PEWD5vnnNx9Df3BvoYxqNtONc2Ht96zrIHFe
X-Google-Smtp-Source: AGHT+IGIYq93CKi8OSj8ClnvKD36PL+CeAVrFU0fxaJlJ3lvOtN58r2VCxwx5Kha5hH09rJI6fEg3A==
X-Received: by 2002:a05:6870:96aa:b0:277:e7bc:69fd with SMTP id 586e51a60fabf-287c1dafc27mr10088239fac.13.1728351821709;
        Mon, 07 Oct 2024 18:43:41 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-287d70eb210sm2593033fac.23.2024.10.07.18.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 18:43:40 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Subject: [PATCH 0/1] Add power key for pioneer box
Date: Tue,  8 Oct 2024 09:43:32 +0800
Message-Id: <cover.1728350655.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add power key for pioneer box.

Thanks,
Chen

---

Changes in v1:
  The patch is based on v6.12-rc1.

---

Chen Wang (1):
  riscv: sophgo: dts: add power key for pioneer box

 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.34.1


