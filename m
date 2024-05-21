Return-Path: <linux-kernel+bounces-185380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD3C8CB438
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E411F233A4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0031F1494C1;
	Tue, 21 May 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="oL5DUW+t"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D114883E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716319639; cv=none; b=YUzdVs4BrwAqSx7NR34RC9UiFhtemos14/T8vRPOdeiSEPKVCNS5sY2QiWMuwc23lmBMcThjHQLi7gnB+DUpTxRA+WLQCIdrUzj67m5gcmisjkQHssHuU8hY3M/vqz83INIe4HtNVf+JqRWmXko3WnTJUhZhVqRH3MTPcf1Ytmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716319639; c=relaxed/simple;
	bh=/5LJJk96zOYAd1s3zbgIV8x3/5mg3XuUvE6Gz54Fo9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwAXFLwizrGGT94P9cLHyuxBoav5UY5ouA91PWoXnPUveml2YZ7WP86V6dGLABdn/+FH7V63c1XuBGkL2jomB6BdMKp+vcJshO3+Llpfp9gyAcIiXi1G6d5OyYM+ZSymKWcBRc9sZD4gN7BJKXGvjtUPk25YmeWdcJBQJx/7CFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=oL5DUW+t; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bd9061eac8so522091a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1716319636; x=1716924436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uD54di9/3KSU1csIqNnGenHNf0jpGZ/KT+RBkitwoy0=;
        b=oL5DUW+t9tu852crd+Tvfp10LqzekHCOCQI6xKNGjgNk/2bj4cjPs1PaAqmd0e6skQ
         2gzhyepU0axvhBLkT5Cwd9QsyzWOlXbVSupaKDtNn2DqIe5OQOjkdtpaEBwHnr7oyduW
         /DZeMZQp3MOoFlLpfi/ZyivXDKmE9BfS+qnsBACXI87D8MJuuRc3j30h1vxcHJR6Ij5t
         Q4jAr4qrqb/h8vUqrQLJYNyK684GHvxtFptc+I36HDdom22xXvkLeEEMdXuj5wNjSnji
         Ba7ZX40c82nFFYFWuAO9ezTJtAT97rrCyKYu5ROB+s4X/kPzNnNcmRFVAzoJIzckBb4g
         AWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716319636; x=1716924436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uD54di9/3KSU1csIqNnGenHNf0jpGZ/KT+RBkitwoy0=;
        b=JNHXZyybxKO+OBdQQ4sLWUkxlNxJborVruHaZLF+VQVveuKCNOD80OYXSkKS6G80te
         QelF5sFni+9i7/u1AF7Ab59+FwE+nLKL0KintV9+dU3bNI/gfEsLUnOU0TaOnMrhAKTH
         +H4z9bmoN1JlihxvuPgOraM8lf1TrRz0qLtcI1Zln/wmDJhUbTN/olmA1b0canTJDI5C
         An86NRLKQl8oVQFJVvrFPRGDA4xiWb52lOt4uD6zQmO4m71N3CEHsykmk1zs8FIfjyPK
         GhDL+4j8UmsWRPyoMMJZQ+rkH3Ev60zsOfkBudWz1IFqsno1mNIrbSer8w7rcgpVnkmD
         WSyg==
X-Forwarded-Encrypted: i=1; AJvYcCV2ShUR6hAkc0p2ekTGCDPv2X4FP///heQCRiT5GDTQNb7iZxyDEn7qRiQb/ltsyJSek7kPg25pJQ2LTfkPJJZmJtpEgHM2RYKLE7eV
X-Gm-Message-State: AOJu0YxmH5++bmDZWdmKxqXGztIvaS8NjXZ0AohKHZskFnB07QZauciV
	B4V+TWILId63fG3lWJEyHF+q4fK74CemgdGLsUhpqczEohv00KecTweSPaQRoDk=
X-Google-Smtp-Source: AGHT+IF7ocvNRXtIXYpalAtaN0Dh0bbHXRi/WE9QPHxj0DWnjICpXcIVasXK6+CaNoVHhEww2YEOfg==
X-Received: by 2002:a17:90a:dc0a:b0:2b2:4c3f:cf08 with SMTP id 98e67ed59e1d1-2bd9efdc164mr153109a91.0.1716319635697;
        Tue, 21 May 2024 12:27:15 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bd92b3d2b0sm1760535a91.3.2024.05.21.12.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:27:15 -0700 (PDT)
Date: Tue, 21 May 2024 12:27:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, Hans
 Schultz <schultz.hans+netdev@gmail.com>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kernel@vger.kernel.org,
 bridge@lists.linux-foundation.org
Subject: Re: [PATCH net-next 1/4] net: bridge: Add support for bridge port
 in locked mode
Message-ID: <20240521122712.3d09b03c@hermes.local>
In-Reply-To: <20220207100742.15087-2-schultz.hans+netdev@gmail.com>
References: <20220207100742.15087-1-schultz.hans+netdev@gmail.com>
	<20220207100742.15087-2-schultz.hans+netdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Feb 2022 11:07:39 +0100
Hans Schultz <schultz.hans@gmail.com> wrote:

> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 6218f93f5c1a..8fa2648fbc83 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -532,6 +532,7 @@ enum {
>  	IFLA_BRPORT_GROUP_FWD_MASK,
>  	IFLA_BRPORT_NEIGH_SUPPRESS,
>  	IFLA_BRPORT_ISOLATED,
> +	IFLA_BRPORT_LOCKED,
>  	IFLA_BRPORT_BACKUP_PORT,
>  	IFLA_BRPORT_MRP_RING_OPEN,
>  	IFLA_BRPORT_MRP_IN_OPEN,

NAK
This is userspace API, adding a new value in enum in the middle
will reorder the numbers and break ABI.

