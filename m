Return-Path: <linux-kernel+bounces-305859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A224963556
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40C8B24663
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22C61AD9D0;
	Wed, 28 Aug 2024 23:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWXwYueT"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504F157A72
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887480; cv=none; b=o50kKUBRwaowMRQuKOm1KvGmb9dPAXEq2VbPJ3HHd1J0mpnQCyuCU+tvCXPcyHi6CiNnQTIjxN+c59+cXglTIGfgMH8YCeEs+18hSE7PQBBGs00bXWKRDUfkL4Kq2Q4kTALi31qRg4BwP9WTWxZ+UpuxgAts4T4Rw7h6hRjJyBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887480; c=relaxed/simple;
	bh=YzC3l0SPYNdRs8e0g+Ue6izyHAH2kRRuH/fHgRjaVfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIMak+1IrVCyGjMuWNwGdaAix8wS/X269GdvwYDIadIySGun9pEh0Xojqm2n0qRpyDrBwkOEpr1uwcz14zjFY53SvVQTFL7d00SURKAGblyIOGd3qOqnZ2ChkahZbS0uG2iz2viSyZ5I4xaSw4RZwNA0qcEfcd62GxBYob7vhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWXwYueT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a843bef98so921066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724887476; x=1725492276; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS5jvGFQTxnaGcUoGpcSDSrzUL1lx6XO+02fCVzW1TE=;
        b=VWXwYueTOxjnEaBUUtKS/nCHRRZqoUDwP4IKrkVAqHFZofM/hUM6yY4rMwYnFQY+uo
         e+ggP7P92Nuo4/TfVknryXpDvBE0xIybXV/7DNSthpLmSnc11DM6ojZO12hqi98IlBvn
         rUv8KfkM/pvjZQ4M1x7bNUrUwy7qlcoAN7M6DrcE305hCIuBJXatiJojPDrbqvRWWA5b
         WgyvdRUrWqVB44Ri2Pmr5AlMFmpPFUelxCtSMj8OR9VRIyvW5v9q6WCQEsuCCTa74FlO
         kYTKF/25MiqEfg2uHjK8yabvJCKDcyVOXLO28DbcwTTCIyPryDl+aazXJh05a8wS+Vr4
         xSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724887476; x=1725492276;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jS5jvGFQTxnaGcUoGpcSDSrzUL1lx6XO+02fCVzW1TE=;
        b=aprNYVjaCC8pbvHSmXhOGgaFY+lF2h1DFhClGiyGUbbU8tmfwo4vHYkgf5k+oIXUhJ
         93wFN74z0e2tNGCEBEW64e+4IOyM6R8Aq77D2DrRIclYQaPmH2FI4ru2FyC6Z5EvkvCc
         XLU/AUWQ3RZpdgv3MG7kc4D73aUdQa+AlXfJcWwA632wlGMilnpx4/9oeP+qQqkjD2MW
         I5Ppdfe/fS9AZtxEULkvFwAv/jLETJj5IrPR9CdGTeaV7hxRNs/O6nnOIHyZYZDHng+0
         AmSw2Su9O05PkxcKicOY/x2ZlIDqFjYUzkETs0Y/RbHzRe2s9biWUqaLiNRqE2PQtPyY
         sh/g==
X-Forwarded-Encrypted: i=1; AJvYcCXTPm2HB7d0L32/Qg+fLzqUEMyuGhA7JuHbJuLDY7OLAOS4eSeUP5ULXgkLo8w6kZct0f4XgdoJbzfgXPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW8+N4Pshxd50wYUUsBPVAap+8oBpUG4MZHYWYT20iUP6rt/Mc
	1QWQKKR/UjfT6KwEYauwrkpebdSxCY+jA2VstZydxxdyQTJJXVO/90QN0Q==
X-Google-Smtp-Source: AGHT+IEcoDKrz4+aO75Zu5ZcNu4XcLSvMvJ6Wd+L2gEaNS/sVWTBmX1yKN8yw1rvPSO1nmT9xAB1Uw==
X-Received: by 2002:a17:907:7f15:b0:a7a:aa35:408a with SMTP id a640c23a62f3a-a897f83b281mr69122466b.25.1724887475930;
        Wed, 28 Aug 2024 16:24:35 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900ebabsm4094666b.56.2024.08.28.16.24.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2024 16:24:35 -0700 (PDT)
Date: Wed, 28 Aug 2024 23:24:34 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/2] maple_tree: arange64 node is not a leaf node
Message-ID: <20240828232434.4ykzuy5mgpqpyddk@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240826012422.29935-1-richard.weiyang@gmail.com>
 <20240827183426.ac84f442e18b66a8ce6bfb90@linux-foundation.org>
 <wxjq7waqbtsbrdl3vmbpcyngkqgndyskn2av2zmwqr4ggglkgq@n67jco6acbbr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wxjq7waqbtsbrdl3vmbpcyngkqgndyskn2av2zmwqr4ggglkgq@n67jco6acbbr>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Aug 28, 2024 at 02:57:45PM -0400, Liam R. Howlett wrote:
>* Andrew Morton <akpm@linux-foundation.org> [240827 21:34]:
>> On Mon, 26 Aug 2024 01:24:21 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>> 
>> > mt_dump_arange64() only applies to an entry whose type is
>> > maple_arange_64, in which mte_is_leaf() must return false.
>> > 
>> > Since mte_is_leaf() here is always false, we can remove this condition
>> > check.
>> > 
>> 
>> These are pretty simple so I'll say lack-of-a-nack-is-an-ack ;)
>> 
>
>Let's make it official then.
>
>Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Thanks

-- 
Wei Yang
Help you, Help me

