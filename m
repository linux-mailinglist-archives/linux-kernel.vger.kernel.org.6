Return-Path: <linux-kernel+bounces-197888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB28D7066
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 16:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88511F224F1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED49152184;
	Sat,  1 Jun 2024 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyDCi9Bh"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9531514F4
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717250938; cv=none; b=jg+EYPWH6hyzVzHnpe/di+dTQdRBQ8iFCMtWIoxV2ZNxkx7HTLKSM6Laats9of8WVZ4kyidEAk619OfvrYPY86tTlPQptbnbt0QB7+K/RPCFHm2z+nQpxRrTG2v3z0e+DFNkCOkiwYnhsTbTFC1Uz8ucTpZlp0Nekcbqg50lybo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717250938; c=relaxed/simple;
	bh=3t+BML06IVnV7ynV1fM/bPeYDyEkk1mlyGKdts2XJ/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwtgpJhPHDePrJYKilbTphI9IfnLNfzOlQIxxG6LyNQSGiSYx9w3pRri+sz+jMIAQn++XGTphlVqxMwtmETdJaKYwbyyfgTb+5vH6H5VfKHTKOG+2aqzdwEl1nNtWnArIQ1rscLGbVyOZml58I7/a+pSO1K3XOiQcEoVIqCyIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyDCi9Bh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a68c2915d99so39285366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 07:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717250935; x=1717855735; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edATjeB/5g6MuT2r7fSukbeeRP93Yoi/adtnAt3XIII=;
        b=eyDCi9Bh8xhscP++uegVZIIogS/pP4s/hSGCANWJ4hm2kZyfSU0eUWgCn1GEuAl659
         HN9ylGADwQaIq1XkfcN4HALgw/aLyd8d7pHcopBVRlbCPrulXzhwLSr08x2oSiYuAJdv
         dqwglFUPBCSz6zSVVtqE2I1XnMBg1l1S5hIjF2NbV1Lzv8qR0HS9fyp7yKhsi1BAtFsz
         3pSq8arErgn3nAn4K9RJkH0G9fV9SKLjAEjf018bo4IUvD/hGR3GP5p5LgU6ku21/IJ0
         SO1Ve2xZZewc87lPNItg29XdhDejbwxMYEkPuZShUZxkWA0FjdT/35lccTttQPb34x7A
         vSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717250935; x=1717855735;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=edATjeB/5g6MuT2r7fSukbeeRP93Yoi/adtnAt3XIII=;
        b=VjlHSjXAMdBYo+0JQYlVOTILFGInSoAZ/Ni/3/MLTqsoE3xV7FkG9RIEs/slNVwxxh
         6Gpu9TusQbrlBoYl/RJ5phpB+y8A2Eu8+3uZ9uCS5hCa50buKDq2b47erE4aVLneQ3ib
         W9RRKn7jNrZVx8Qoqeo3m0oEX2GhuWVY4PWzw25SvSFffUQTGKjXS9cw0bV15NBX1nVw
         yd02WyfW9adkPK/2x8BJu73si5ZoGxxyM06Lq/yStDXWH9YbDkX0hrRwGHYld8TF39tg
         UDJEmyQD1Hki93RWXTAdfCA/B65RMHv2/6YZQnUYPgTJQ4bJlqCQbD6oS1Jx5xMXf96L
         BPyA==
X-Forwarded-Encrypted: i=1; AJvYcCWSwXXK3+Nl5WWOFbZTST0AB8VvlIZM+tBcG8g0kwZrihQUVkfG3Df1pl6da/fWN1PGzdWJwpBsBwKcpcfGWOWRt/DdRdhqOT2Bepr6
X-Gm-Message-State: AOJu0YzQVKYkbK/2wtRqOumU6r6AnHhKHVDJWTHt+WKbcAHMnGnEEA3B
	T8uAD4HHeANDE92+OXEddX22hpq7bIrHEzVRAQxa0+qs3xGQScLyJKzQtA==
X-Google-Smtp-Source: AGHT+IGxLtxVd0IPAjW+Jh5EdJYjrO4L8rChjkDCAXcjpU9q6LvNUOlg+ipa4NZewPfxROT1kIZAjA==
X-Received: by 2002:a17:906:e084:b0:a68:bb1b:4de2 with SMTP id a640c23a62f3a-a68bb1b4fa3mr87036566b.3.1717250934892;
        Sat, 01 Jun 2024 07:08:54 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68a2fc7707sm102544366b.98.2024.06.01.07.08.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2024 07:08:54 -0700 (PDT)
Date: Sat, 1 Jun 2024 14:08:53 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] mm: userfaultfd: Use swap() in double_pt_lock()
Message-ID: <20240601140853.n4k72xbjzhtgm4sn@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240531091643.67778-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531091643.67778-1-jiapeng.chong@linux.alibaba.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, May 31, 2024 at 05:16:43PM +0800, Jiapeng Chong wrote:
>Use existing swap() function rather than duplicating its implementation.
>
>/mm/userfaultfd.c:1006:13-14: WARNING opportunity for swap()
>
>Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9266
>Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

