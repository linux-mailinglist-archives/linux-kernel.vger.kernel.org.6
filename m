Return-Path: <linux-kernel+bounces-431148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 679189E3A06
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF940B318E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70661B85E2;
	Wed,  4 Dec 2024 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljZNXT52"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F108198A32
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314010; cv=none; b=Yhd15xPfe3a0169FxzspiYJE+GXTmhGUZrgR5MKraFo5Ekwlhx0lQVb6HmJeWS0MP9ZD6g0LhqpRVdaiB0dx92fZZQ8kDI/adYWzya2cSm0x+FwBP/8zQa4oCwBAKq1NEz91059gBFJXgw3VKrXrdRb2ofMZHTdQbV/f8sf2rOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314010; c=relaxed/simple;
	bh=JDuHv6uKQbsHmnfZl4eZomwStWLbB2P9XNr61tQtoTk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OIJvmBYtfqSqOn2y3zv3W7+GD1Lt7cpkhetWNsvbeXDGczH4XVl69NTgthVLOU+s+8x9IXuCaSJogyFi2a7dZj46RVWrs0RKt4VCuAOtjnuFGHCiWWBxpBUHxazi6VCNOlYSAbnnUrE5L6HI4rKTuCSR9zeEZtSDBqV3BLzM2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ljZNXT52; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434aafd68e9so55321965e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733314006; x=1733918806; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywma13jqMEAR0GKd8Er2i+hQcM6w7VPqBl5YrMVzLNg=;
        b=ljZNXT527HsCuXDN04ftSTOa7EdLqkLaJgxqyahBN/Hy3l0O+uPycEaB5EmEKsdMxe
         kV7ey+bTmpyZV6esyDa3I5Br6Pmw77su4JefNShB474nT3N9vmjSh79QBlWEo4y7UNUl
         XOAH6Ioxsx6Dpk94+vGwVOHQXCYsFUXRhU+5JxbfuhF/sTw2CFWpQn1vQhP4NOuH6fwB
         4/MTZgWGcwrt3XDaFjKwYS9Q3voxeby96NcSmTjWllX8xAjFq6/INHXwPVsuRUWdqo2Q
         sWEvU1nRomKubzL6/hzh/o4DUxrFDJjzPB7kNhTI66RxbAYXJFLdp94NK8pCESdn/b8f
         XQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733314006; x=1733918806;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywma13jqMEAR0GKd8Er2i+hQcM6w7VPqBl5YrMVzLNg=;
        b=JXhC6BgT+oPprC6kz07iw/x9U42Vk8Je4HQve7nW6EzKrrkV70IOpZ2jSP7t8qjG0o
         P9wDvXVayxuY5F7GdKcCwuyKUR+QxuoOioPJWyk3S0iq3cgq4ueQ+HwHYb8OBgQGQ8Cc
         sSfqlmtDmiuI8AVyqn+u2d62lFbQa3psJ0EZNM23OTAXOSSVc23RQ49HGyuY939G0D2C
         0SHub8fZshBPnmztPstxbw2IQ90nqm3rQ9QSu2COY4srm8yE2LDdCG9zHfxE69+6ys35
         EFv73mGiiuU55MXkwJFgiQjIRyRbmIeNbKvRr1X2C0ddC28p13njn0cnHGNKndmrh6X6
         iY8A==
X-Forwarded-Encrypted: i=1; AJvYcCV4iBEQshx21kDv8q83ruGoofLfLKszEQhqdiPvAvrSMitksBQQ3b90MlllfZpAskf3t9vvMBLtDRz4Y6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ43zKBKi0K8RfO7uHYn476EcpZmaGXv1CXMr4bDRRvIu3eJCb
	oAiquxsctuWpS0GjaiWviw2dW9wxMosSYZ0IKR3Mm0i32ZnfiG3XB9CDOvDgdvE=
X-Gm-Gg: ASbGnctTL6OhYV49TPVyvS75/fWPMfRHS//ma0VsejC0yf3wsVI6OJny3lBxmQ5Ozzg
	he/Hhgv42N2C6/4VetBI42CA36+Gma+HbbnlFEJgFkoEuEjv0wDnJx0Z4xeKbbB1wnj04QV8UDi
	lM0bSqOWvkiQSHJ5fRov1lIxOCz4Rui2fUGWlLo59WZaxl+LXFaRdvdUPrM8VAhCl7mUZ/Pey6Y
	+iyQmSlEpYZQJ9H3UXxQ4rU8izSq9pMDJN6GywW1PpuwGCht0l3jZs=
X-Google-Smtp-Source: AGHT+IGJUj6d/zYcZD5M/Et3lJs2ShDAAV/RYF8yEIzq3ilyWBo8QUqo+ERoO6DKk5D16w9J5pmwRQ==
X-Received: by 2002:a5d:5f83:0:b0:385:df4e:3691 with SMTP id ffacd0b85a97d-385fd418da7mr4972574f8f.42.1733314005639;
        Wed, 04 Dec 2024 04:06:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385fd599b31sm4473289f8f.21.2024.12.04.04.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 04:06:45 -0800 (PST)
Date: Wed, 4 Dec 2024 15:06:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v3 net] net/mlx5: DR, prevent potential error pointer
 dereference
Message-ID: <07477254-e179-43e2-b1b3-3b9db4674195@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dr_domain_add_vport_cap() function generally returns NULL on error
but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
and if it's and -ENOMEM then the error pointer is propogated back and
eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().

Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: fix typo in commit message
v3: better style

 .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
index 3d74109f8230..49f22cad92bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
@@ -297,7 +297,9 @@ dr_domain_add_vport_cap(struct mlx5dr_domain *dmn, u16 vport)
 	if (ret) {
 		mlx5dr_dbg(dmn, "Couldn't insert new vport into xarray (%d)\n", ret);
 		kvfree(vport_caps);
-		return ERR_PTR(ret);
+		if (ret == -EBUSY)
+			return ERR_PTR(-EBUSY);
+		return NULL;
 	}
 
 	return vport_caps;
-- 
2.45.2


