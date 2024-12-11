Return-Path: <linux-kernel+bounces-441973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A889ED638
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA95282127
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C6B2288DC;
	Wed, 11 Dec 2024 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tucAvi5M"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96F2288D2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944186; cv=none; b=CtHPuAa+MW1m0pzCqpG+i9AcxSHeFS5EBnyLZwClHbcu9PnKHkvJYt/Pl91U0kJxuP5+fpPzQ7sjdI2J1bl0IpyhHaAe77PKRI2+NKvMws+khdQAHzCi3Kz1AocxvoWkpwMc9zN/J6Fep6tB/AmhH+zShdrfBz654AUq4wL8hsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944186; c=relaxed/simple;
	bh=/CIkg7HKHvzn/oX5rRMxHx5dcWx1Yz3xPhxKwe6JZ8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DYD4yZv9o7N2inLXB7CkREjwzlE9Q0eBXbQRVvKi8+Mr1jnSxuaJgAR9J2CV4W/wZ6Jzpu/51xgL/3lhqma2XBxp9KufWBCatHDJeYYBjhymPNBYEBXLKVZcqMk2GUcqDDerGaXmtjE+OQpDEGdfjbfpu3TH5Gxy3pf2xrc8ZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tucAvi5M; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 805563F1D1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733944178;
	bh=/CIkg7HKHvzn/oX5rRMxHx5dcWx1Yz3xPhxKwe6JZ8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 In-Reply-To;
	b=tucAvi5MDaX5NfPI3M+qaSDYBUL0Qr2AJthKUJsfItlitw6rvREReVfaR4jj/YgD4
	 DJKrSiQZUVFb8icNc0zIaa++pnW3c6N4rN2pESo6/w3uwlPk1WOIemDn3ADs9CaaWt
	 y5FOJD73mTOD0NEkNau4vIq/2ocajtgmN75NzC+qUNT9erlj9rV/WZpYrtlqSN5/Nb
	 qpBJS1/XX+Ts+0TSYBQIozUVR6pnAM/nUH50rsfcfJkSjUO7+0k9hoUVSTWPsOZdRE
	 Lvd024vD0UiOq3KZtoN3NwzOE5aYr/HQtsSoYnJLXovbJc+KlpXlFFUqQU/jzzxIUR
	 miaS3VcmzaGMw==
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6d2ae6bc0so659197985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733944175; x=1734548975;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CIkg7HKHvzn/oX5rRMxHx5dcWx1Yz3xPhxKwe6JZ8Y=;
        b=rRDnWCOz8Cs81jALxL19V3AcWAEJXWdz5ULv2T+V+KkKiSv7qubzCkXJ3LwIxstrCW
         SzNgM5f71yM/LmBDBuqbpFHG1JHbRdvR0kLFTb8COahLq699JvBy4TZgw0SQeO4OqvFK
         o3wbncvCvw4WoZX5sCv2bSF493e/0KVVErsqJa39Yl1C4sMt9aVjCUU+LjNXj127IJwC
         ydVQS2jnH+eXIslHMbGxtglsgUfPBUyYECT3NAGxamuXo+awkYD+nGKFCrXMnsgTB7LU
         RxV4i47y6sIvWP8/cMNfW88h/dDvh4Txqj0O7FZt8Rf+4PI2LYBpxedmIdjxA52OgLCo
         aH4w==
X-Forwarded-Encrypted: i=1; AJvYcCWuLBWXM0U3ePUQjiaFHHaNit/662pWn8bMeSiM/zankRBZpmrEai9m4ZOZjBr4agVouUSgjiDSBxyI5rA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0K5EnVSrp31WcGoD6Xydvo5tdZQeEOaPOE8GYV1qrKghwFbbt
	DuyjulXRndj6G+Eu2ELj+BPZ5X34ZpkAcPqmOtcqVzP8UedpAcnnAOHmZx7fDOJST/YuuIk6h9a
	R3ZMIfGRJDnzXECeFCqwzR/3H8Rjx6ASribtxk+2xGN8Ysy4aSV0tcQGFz0Q3HxA9oEqpgo7K2O
	idHVKM+x0RBEUj
X-Gm-Gg: ASbGnctMs42FozTkqlpwtsp5AJYVeH1aYjUDBc9ds4vuY13jxMCE7ghFFnl6195HFiM
	RLcdS6mch2mBeP/8FUN2hy8KMNI2B+G/ZdE4DFx7jbcJOEb/QtmtN06Dg9uiwHenBSKBvJSLMnl
	bpT1Jm4GskecMqxl8oqtYySZ3kHMJRw0GSuIoNYqXUAZkkZry4h8VhVl+lS2v98Y/Yg5z+XCw4t
	iZE3xRW4+mur2vNR1ZIaw4aBVuYwYEuX/W3OdxbWnqwL1bYQtd0ayiHcg==
X-Received: by 2002:a05:620a:4452:b0:7b6:e9ca:a299 with SMTP id af79cd13be357-7b6f25278bbmr72358885a.5.1733944175574;
        Wed, 11 Dec 2024 11:09:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwt1m9rl72WJB+oiLg7qvbOMlZq50TK3HAqBiCZxMkmyGBpMeqPI+DU/cXBc2WkkPxr5hDHA==
X-Received: by 2002:a05:620a:4452:b0:7b6:e9ca:a299 with SMTP id af79cd13be357-7b6f25278bbmr72355985a.5.1733944175331;
        Wed, 11 Dec 2024 11:09:35 -0800 (PST)
Received: from localhost ([2601:86:200:15c0:3d00:dffb:d565:6a8d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6e92f2e48sm137232285a.25.2024.12.11.11.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:09:34 -0800 (PST)
Date: Wed, 11 Dec 2024 14:09:34 -0500
From: Yuxuan Luo <yuxuan.luo@canonical.com>
To: gregkh@linuxfoundation.org
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-53102: nvme: make keep-alive synchronous operation
Message-ID: <wggouxdfutckxi7fatpmpo74j5bvannhzp25g5lrjvyi7qffc2@6y5fbuse6ypo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024112507-CVE-2024-53102-a45c@gregkh>

Hi Greg,

The fix commit for CVE-2024-53102, d06923670b5ia ("nvme: make keep-alive
synchronous operation"), has been reverted by 84488282166d ("Revert "nvme: make
keep-alive synchronous operation"") and the follow-up commit for the fix commit
, e9869c85c811 ("nvme-fabrics: fix kernel crash while shutting down
controller") fixes CVE-2024-45013. Does that mean CVE-2024-53102 has been
invalidated by the revert commit? If so, will you reject CVE-2024-53102?

