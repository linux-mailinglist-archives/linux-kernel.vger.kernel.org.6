Return-Path: <linux-kernel+bounces-365890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D7299ED8F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE851F21DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C08A6F06B;
	Tue, 15 Oct 2024 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqZdsK9l"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE041FC7D4
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999092; cv=none; b=ZSEB7Pn0FZEn6PDgVhezTMvq7JhkG1IGUv8yaiZqMpkajWmLKydDkQPFBElaDDfOp8whV5PXUOO0tKAHgt4GA9DUNTTlLM4p2cDtg96hG54/XugRjoDIEAqzZX3Y9sMjDBumyCbNVqwIYq4nPDi/sLosjUs0rYjV4HmePlIXONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999092; c=relaxed/simple;
	bh=92jATEcaogAVLPkZ5Iw9Kn3gy7UuMqNrjmOi0wbTjyM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MY/UY4hMAgsAwdMOcnIOYzB2oVLdK17hkyhKDghrEMiuUvna1kTf2dq1EVf8DqBp934EmGW7TTyYPyfTL5UKep3M0AX+b2ikQM4zIybY0BsCVb4ryD2/vsNhGk7iLDQq1GgJlSzWq2H2vtXNyENdgsHacEPr2xzuTel/wJRATVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqZdsK9l; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb51f39394so20460301fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728999089; x=1729603889; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46mrZaJz5A8gmyf2ZZGCnAO8T2IkKjPfrsulNuqAvpk=;
        b=YqZdsK9lHYMByOshTjGVWH1kFAnpXd9C+i0qW9h9Li57mNpmpT2x9+5hHgHWrWZH+4
         no4D9ab8r0En+N4poqH9Goy9PSXGzYvQXSuyRJJiIk8WujGo1jUZi4CghdWVB9WKnR0R
         PbS6m/1PTKkxhx65gkpV8YRfltFYEVkdsJOAvOcEGod64rb4CosSABSUW0JJjDTZSFLF
         I89YGVAWpPA0HMIXnuhBupEzvMU9bCAcRM0VXdXDi3bT/kQqxSC4vINwZXxx17pcenjR
         oC51gmIc9spo3vyWbSYLPEANbR3YSGdumnkdW419pPu+9VRaXhb5GMm7z+HJmr5FH/2r
         RhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728999089; x=1729603889;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=46mrZaJz5A8gmyf2ZZGCnAO8T2IkKjPfrsulNuqAvpk=;
        b=Nhbk9Bp9anuUNTio+wvN6x8T1ZnVv/q37h5oD7yfE6ekJ0d4WB08gOYdxdmHCDujK9
         WdKx5SF3gQEF8Djw7dHKgnVbeIWvVtl3dXQUwNHXFd1AexLpiGu+3+rXMZBcgz24vIhA
         Nx8/7u4LMoEYZ6lvO7P1E9G8L1ADZ6X59WN+hg8NAksqqNbwpYzJgLJFfVjsproV5jeR
         +fs8yxihmtIvieEMYg1nA20IEJ3qXVUEuz9nG11uzA3tL0qPmw8ilX6uC0DlAWY4jXrD
         cqDrKU8dlBG/5tm1FSPMhrzNckNSnnWNHsIA6xiNScsvcuzgrCvblD+6zEjcxVu64KA1
         /8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwE60b8xvU8wqNd3zio3P3V5Zm9LwDtd/gEfwH4lO06AvUHmE6RDG6LgRmkiehR+wXVY1MX9b2tN3XbZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMwO2U8TKiD5gRSHI2TeJGutl94SHiyAe/lYeXGxiT+p18H+w
	GlxgC2tCVruvVeOoPyTbgLwjc6KzzeIYB/iiSBkzZSPiXy0rs+D6
X-Google-Smtp-Source: AGHT+IGSNcimW+7z1u8OqBLcuUwQwNc6Lat0Yu/fYMeyYqUjgyYErLJUwCcTDxvOejHs/ry0iXaHAg==
X-Received: by 2002:a05:651c:b06:b0:2fb:b8a:7abb with SMTP id 38308e7fff4ca-2fb61b6ebbemr3222721fa.21.1728999088592;
        Tue, 15 Oct 2024 06:31:28 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4d6851sm709470a12.5.2024.10.15.06.31.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Oct 2024 06:31:26 -0700 (PDT)
Date: Tue, 15 Oct 2024 13:31:25 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiazi Li <jqqlijiazi@gmail.com>, linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH 2/2] maple_tree: Add some alloc node test case
Message-ID: <20241015133125.aixhbw5kunbme2nt@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240626160631.3636515-1-Liam.Howlett@oracle.com>
 <20240626160631.3636515-2-Liam.Howlett@oracle.com>
 <20241011011759.wbw56sqgmhzjwo4k@master>
 <juxyinlfa5gn6pbhvae34xamz4zx6d5lmbkfeo5uwg5hu4ctj2@ruvlfmtbx7ji>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <juxyinlfa5gn6pbhvae34xamz4zx6d5lmbkfeo5uwg5hu4ctj2@ruvlfmtbx7ji>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Oct 14, 2024 at 09:15:07PM -0400, Liam R. Howlett wrote:
>* Wei Yang <richard.weiyang@gmail.com> [241010 21:18]:
>> On Wed, Jun 26, 2024 at 12:06:31PM -0400, Liam R. Howlett wrote:
>> >From: Jiazi Li <jqqlijiazi@gmail.com>
>> >
>> >Add some maple_tree alloc node tese case.
>> >
>> >Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> >Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
>> >Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> >---
>> > tools/testing/radix-tree/maple.c | 22 ++++++++++++++++++++++
>> > 1 file changed, 22 insertions(+)
>> >
>> >diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
>> >index 11f1efdf83f9..b4b5fd9f294d 100644
>> >--- a/tools/testing/radix-tree/maple.c
>> >+++ b/tools/testing/radix-tree/maple.c
>> >@@ -462,6 +462,28 @@ static noinline void __init check_new_node(struct maple_tree *mt)
>> > 	MT_BUG_ON(mt, mas_allocated(&mas) != 10 + MAPLE_ALLOC_SLOTS - 1);
>> > 	mas_destroy(&mas);
>> > 
>> >+	mas.node = MA_ERROR(-ENOMEM);
>> >+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 1); /* Request */
>> >+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
>> 
>> I am not sure why mas_nomem() is here.
>> 
>> Without this one, we still can trigger the original bug.
>
>It will fill the maple state allocation.  Might not be needed but
>doesn't hurt.
>

I took another look at it. We really need mas_nomem() here, since we call
mt_set_non_kernel(0) at the beginning of check_new_node(). 

So mas_node_count() just set the request count and mas_nomem() does the real
allocation.

Any reason to design test case like this?

>> 
>> >+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 1);
>> >+	mas.node = MA_ERROR(-ENOMEM);
>> >+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 2 + 2); /* Request */
>> >+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
>> >+	mas.status = ma_start;
>> >+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 2 + 2);
>> >+	mas_destroy(&mas);
>> >+
>> >+	mas.node = MA_ERROR(-ENOMEM);
>> >+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 2 + 1); /* Request */
>> >+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
>> >+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 2 + 1);
>> >+	mas.node = MA_ERROR(-ENOMEM);
>> >+	mas_node_count(&mas, MAPLE_ALLOC_SLOTS * 3 + 2); /* Request */
>> >+	mas_nomem(&mas, GFP_KERNEL); /* Fill request */
>> >+	mas.status = ma_start;
>> >+	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS * 3 + 2);
>> >+	mas_destroy(&mas);
>> >+
>> > 	mtree_unlock(mt);
>> > }
>> > 
>> >-- 
>> >2.43.0
>> >
>> 
>> -- 
>> Wei Yang
>> Help you, Help me

-- 
Wei Yang
Help you, Help me

