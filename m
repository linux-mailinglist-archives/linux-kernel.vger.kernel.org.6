Return-Path: <linux-kernel+bounces-232883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A6791AF6F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1BC1F23F51
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B0419ADA4;
	Thu, 27 Jun 2024 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imCvok/Y"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E38D43AA8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719515252; cv=none; b=dGBwcf8HNzEOBULkW2zCJWg3kh9VB9S9s5QRzzEIa7Qf9Aiqv7PEpj1ymBdInkeAV4eZhvZ4a+42F2XcyDjApOyHA7iY8tjqMIDY6RXGQ5NJuY3F6yAIqY+o1maoMz5oravRSuTrnEVd4czau6lrJ7Ve+VXiTeKHxM0GPAXSr6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719515252; c=relaxed/simple;
	bh=MmiVqPBxZPCeDeNdyrDhA9T+KMrsM6bqxMkTJVCnKx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJPcnfhJLOsv7TiRSFadShcJj/thAlN8rGa/mjX+jymXUok0dx2lAz4aMZ4SgUQFxhm4Pz7DCbSh5No0xbkkmET3DV2OTeAbZrFzVJBjit6zplZfhTOkroJ2ewiZpheWcuNH8RYicKp7AUZcZdALLCl8lyxq/W7Bh1Fn2GLnMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imCvok/Y; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6bce380eb9bso5081441a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719515251; x=1720120051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbqrr3I266EMJ2M2WomzXrk0QJRFb07jEIlKxpyvA/8=;
        b=imCvok/YQx26cNSL2i9Dzmq4x9gRwv6EPdV8nAc10T/fkrz39pbgBNNuZV9Xp/dvjx
         zbEq26nvuoYzvRqrKJaYzx2BhZPDs58DwL8YFPBxgV2CkidFsjmm1VOX/9AWi8oJGw2L
         d8etzxqgWNZqtwXtv4OmXV8uVLyczFxmYOVu1Wb0YiDKalGfPxvCvcjvmmKC3mRfeKBi
         /svyi2ZnL6O0fPEbr3wpstLPnh0q7mw+s//VQmnXR8CkH/P2G2CjMxo7eZdUbXdWAAhY
         ETJ23nfSbpCaN63gwZI6UzgQmryW29vNaIQHDsEjte9u3vAPGYYLmJnlPkbE2j5h7fGy
         KVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719515251; x=1720120051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbqrr3I266EMJ2M2WomzXrk0QJRFb07jEIlKxpyvA/8=;
        b=L6oYIDmR9MUB4OomlFXy9AWSGsQ1Fh2vk2oDQ2sGJnlrmflJoCxRF7ln2MvSAF/+uX
         FucwwymqKMo7tO4QEse8eDaU5jS81ZpMU21NswhfsNsh43xA4PafgqegeVH4jrcp+z1e
         B1RRrYag3+UbMdX3ONOzYnoF/ZUw7uRZuvt0dwX5B5Yb4UrrRB/kn6tmj6UDypZCnvrG
         t99J4C7tzObO9QOqc2hYNVFbvTRCZB8iAQ44K7szGIkR2bkjc/TOq8MAUjIuv5vNWRum
         Ac+6oePM0qEHLTqwAVeRLjcoRDIjj0OZdr6lJgQrXJqvaMHgY1oUR1AU5Qj3jQ1zt+X2
         zGYA==
X-Forwarded-Encrypted: i=1; AJvYcCXp8LhfgOSEUFh/sJiXUrzYTmCdosjZjEsXwMVGLit9MkvShqkumvWmAsgDojZum3g/J4nWsqIr3ZfmYLUBWVQFtwQ8t2i60JmjVlTc
X-Gm-Message-State: AOJu0YwAwoQwmpPr44dWJGYKp7EZtNkjqKrS/zRs38wo317pDbbv1BTD
	TdketaVlPV4J8pW8Y/cWQa/6/lAxSwZc/JZrAVi+Oe0W+XsoSbjz02Z7wA==
X-Google-Smtp-Source: AGHT+IEwy2vaUtuReHF3b33P6n1++Z+/IkvApvxbPK7l/ED6fIVar4AflqHP5bIFRD4SxuezSNABRQ==
X-Received: by 2002:a05:6a20:9490:b0:1b0:2826:9e2 with SMTP id adf61e73a8af0-1bcf44d8bd8mr15715750637.31.1719515250665;
        Thu, 27 Jun 2024 12:07:30 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce70eccsm140375a91.31.2024.06.27.12.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 12:07:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 27 Jun 2024 09:07:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: add CONFIG_DEBUG_INFO_BTF dependency
Message-ID: <Zn24cZJpvjUvh5fB@slm.duckdns.org>
References: <20240627184522.1257114-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627184522.1257114-1-andrea.righi@canonical.com>

On Thu, Jun 27, 2024 at 08:45:22PM +0200, Andrea Righi wrote:
> Without BTF, attempting to load any sched_ext scheduler will result in
> an error like the following:
> 
>   libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
> 
> This makes sched_ext pretty much unusable, so explicitly depend on
> CONFIG_DEBUG_INFO_BTF to prevent these issues.
> 
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Applied to sched_ext/for-6.11.

Thanks.

-- 
tejun

