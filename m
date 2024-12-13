Return-Path: <linux-kernel+bounces-445402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCC29F15BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D7C188D776
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF11E25F6;
	Fri, 13 Dec 2024 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LXnz6KiE"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E41EBA02
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734117699; cv=none; b=gjDwMuKmzo2HceZE89UXf8tZ0zfczXLOzM5uSGX3r8H5esOGvCd5FgnCxEnNHKoVJQ0u0o68Cy3qn0giqJ+0NRqObA63tjbQA7njV7P9sHvG69XtU3hFGSMChlRpoQ7WVt2uaYGwKyiLJAUMiqmuZudSA8mxg/L1BFZWlnAiKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734117699; c=relaxed/simple;
	bh=BcaoR0lBJqGjTkLYaCtP20EXrB05RDdYL0aWjOuP9Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NlgeZpBlPh8QvTf024wEILKvJb0khXK+z/48zkSeaT887SyZ55/9cP1hi1ujAFpD8Tg7ItR53su9hb6jc+hZ3Tk0hkm7R455bnyPKgjXvE47D8zg1jln0ZYN9SIZHXPnRs1t2k77FAj3dMhxspAsBv7hE+K21bzKcncKKej3dQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LXnz6KiE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso15437895e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734117695; x=1734722495; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zAz8Dn5rlSBhTOtDk4TKpwsoyrlzs7IaDpD+Q91piS8=;
        b=LXnz6KiE35iVwvvpFPRlAZUd4H+RJ5MmI4iLQTF5jOwYYCGa6tfV7VfgkNZPweiMYV
         FPJ1XlGnF/q2AUs/nxHFodHB9coAvh/6Bo18P6o446UhcPhCIBxK9YPqYsXlBod90+QX
         Na8R8nYFwzcoMKrruithEzzG32MJYyX23C33qZuaFu2Zy8CmG9ehQqG/LuFUfbWnQPHQ
         9UbMS57PeqVNN1Da8Vf7KGoWA0QKFnXDwepxOK5CYNmzOR9+wwFK7+QzAWA2RpnT/bqe
         qp1pvEvN3SVsnAeUWRyJUAXU/Zh82dhmSUoUgQdcnnX9iebKZob3NvGmQPE+wBdOGOI9
         sf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734117695; x=1734722495;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAz8Dn5rlSBhTOtDk4TKpwsoyrlzs7IaDpD+Q91piS8=;
        b=i1Ilq+QRkQBhr+8x6K7nM8WVEkb/a0pBRy1COHj5LImE01bzb4jk+zAjDGWId8G2CR
         xt7UUM/GVndTYkQuDXZ1SuCyqC3RmT1ns9OBMNmnSduzveB31NxIe8P/5MsIEsV9fJ8d
         walPMaPuzQWBr9Asba2m/vinxzCStZ9Lwv8h114s4hxXVzo4+H2bhdIA1v204FMeuLMz
         K3fFlIuUS+vrOV7nkDSxaiZ8pVmRsuNmxPgnvZVindpS4ZJ0/23FI+LqZRY6Vlqal+DT
         WdBFRHPk5cnLrBZFBsHBN+aUa/4htUe8M1AF+bfNhq5HLJHkZixR0uFz0RNbAG3baWUW
         q80A==
X-Forwarded-Encrypted: i=1; AJvYcCUZgjUGl40Ejv9SW0ZGm3axYMf1I2rtwk3hefaXuDSx54ECt9sPpDrcuvSY06CWsH4C7qa4ETFWQgKObSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXXDpvI2PwesGL4LUSem56/p3+Hc4tLhLR0U4hSClke/YOqbMv
	iEAy7erxkP1PhdtKd/Qdo0//xAB3yorDmjjjvFQocywcb38ZZE4HJDGkXgWIZ2I=
X-Gm-Gg: ASbGncsk77+KfDaHmZR9LmBY3ABBOxmhsObG3NN0SPB/M3r7wA1wdNBQaFq5pG0VtCT
	4FqpUO1m6ON5+4ARJpfIAW7VDvgnKnsmTuHz2LQpYd/Q5S6rh0VtdZZOhkUyWAq9KDPnrzG8Zuq
	+R3qZgZhlAuRW7ZV5qDIq1tgzg5YPS3b7x5EMJrRhNXqnd4BYEVJMx2myWzY4p3TzlulpKs0EYX
	kO8ZYWo2G5W5DL/b92XYfr4yP17DBoIuosQ5dJPS1WrfA==
X-Google-Smtp-Source: AGHT+IEsztWIjOrHRoOdBex2SrrGXuErwDUmXFDYNPuTLuXjjCKY8ezzeejJ40Z/k+WwQoHC3cHqzw==
X-Received: by 2002:a5d:64ab:0:b0:385:ef8e:a641 with SMTP id ffacd0b85a97d-38880ae0e46mr3455511f8f.28.1734117695302;
        Fri, 13 Dec 2024 11:21:35 -0800 (PST)
Received: from localhost ([152.250.153.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5044asm1100565ad.130.2024.12.13.11.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 11:21:34 -0800 (PST)
From: "Ricardo B. Marliere" <rbm@suse.com>
Date: Fri, 13 Dec 2024 16:21:29 -0300
Subject: [PATCH v2] riscv: Make sysctl tables const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241213-sysctl_const-riscv-v2-1-7a8a499291c7@suse.com>
X-B4-Tracking: v=1; b=H4sIADiJXGcC/32NQQ6CMBBFr0JmbU2ngIgr72GIqW2RSbQ1ndpIC
 He3cgCX7yX//QXYRXIMp2qB6DIxBV9A7Sowk/Z3J8gWBiVVg0q2gmc26XE1wXMSkdhkcdN9ba2
 VHbYHKMNXdCN9tuhlKDwRpxDn7SPjz/7NZRQoZKNqNLrX3XE885vd3oQnDOu6fgFogRuPswAAA
 A==
X-Change-ID: 20241205-sysctl_const-riscv-ba93ddd07156
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=rbm@suse.com;
 h=from:subject:message-id; bh=BcaoR0lBJqGjTkLYaCtP20EXrB05RDdYL0aWjOuP9Qs=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnXIk8dbgek6IiE4WI/Tw/mNYdnblYgLMhKtMsZ
 tzGzqhGUVqJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ1yJPAAKCRDJC4p8Y4ZY
 plTxEACe4IQ3gp2o7dtJVI65A9ab3pSeQ1X+Nxh1mQZ5qNt0fsRqP3jQdSjm4KDEKjFCoywT17H
 wb/OZ7+fqmAy3hc+42+JNF6sbklbrkwrm+dCNoTnQXMDSHrCpqOnNtgGvV1QxbDtHbo49Q9mZQQ
 QjcOR/nwB7OwUqdav9CtmI+jlemwCW8c6QzS7ERblEpRzXGf7bnESGlInFIQPx/MUCl5xs9zmmi
 poXylmZ3ZVJv9CjlcyqWoXS/eOWSSIG/WtrtUAZKjCLXJB+/vtgH7dawCekR/X8vGUkH9LSg5lc
 tdxPqF+zGVIMzvJGXbsFU2n6pURNkWoP3K0jySRBmdpngAqknfRYjP7WGHws2qrYvGuNGb9xeev
 X2vE7jpI6TLoAmZ3fGOXqEfT8NwouP8myPAFdlt5zbpX2PIKconGrk7yO/t4ieyL76oul7Y6WJR
 UvdzjafH0MQq4QwskCjopejIkADD5X5Qg3clHzvqW9vyugAdqU4URkffbCJDhYnS84CQz//parx
 sW1LVVpyK+PBvSnPM/IES5WacDk+PncytEr0RIrQ8uAMOmTWWclt0nLEvIKMN08YtYSp/bUsM52
 vOLK8zoTJuLsvPEi0xUvNnBdsh5cwgbiHEMJpCSMAj4mIJXYIfFFxVzr6bvxbHPh52uE6qTqKWa
 5xts8I6GVeRnwuQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 7abc9b53bd51 ("sysctl: allow registration of const struct
ctl_table"), the sysctl registration API allows for struct ctl_table to be
in read-only memory. Move tagged_addr_sysctl_table and
riscv_v_default_vstate_table to be declared at build time, instead of
having to be dynamically allocated at boot time.

Cc: Thomas Weißschuh <linux@weissschuh.net>
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
Changes in v2:
- Better commit message
- Link to v1: https://lore.kernel.org/r/20241205-sysctl_const-riscv-v1-1-04231ca9a78f@suse.com
---
 arch/riscv/kernel/process.c | 2 +-
 arch/riscv/kernel/vector.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 58b6482c2bf662bf5224ca50c8e21a68760a6b41..7891294abf4937de3c7e440573844253e856b39f 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -364,7 +364,7 @@ static bool try_to_set_pmm(unsigned long value)
  * disable it for tasks that already opted in to the relaxed ABI.
  */
 
-static struct ctl_table tagged_addr_sysctl_table[] = {
+static const struct ctl_table tagged_addr_sysctl_table[] = {
 	{
 		.procname	= "tagged_addr_disabled",
 		.mode		= 0644,
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 821818886fab06aa054e2ba3266897e9b4d161c0..d022b028ac3ff5375f522947d34166266ceb424a 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -287,7 +287,7 @@ long riscv_v_vstate_ctrl_set_current(unsigned long arg)
 
 #ifdef CONFIG_SYSCTL
 
-static struct ctl_table riscv_v_default_vstate_table[] = {
+static const struct ctl_table riscv_v_default_vstate_table[] = {
 	{
 		.procname	= "riscv_v_default_allow",
 		.data		= &riscv_v_implicit_uacc,

---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241205-sysctl_const-riscv-ba93ddd07156

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


