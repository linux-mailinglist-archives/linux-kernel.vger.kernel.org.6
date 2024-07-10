Return-Path: <linux-kernel+bounces-247784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E341F92D47D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E741C213DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5140EBE4E;
	Wed, 10 Jul 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxOLuUvP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C96383A2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622816; cv=none; b=cVY3I4A0NeVpKDzM/6GmIk8VhSWk+3G1A+grIk2UOWstPTpJVEQU2le8Cp0SdQqtb5n6/ef5IJu0UVpZDTNHZJ5LDPlaYHKToVtMt0nv13VOcqhJQq9XgKOrfOt1HgmhL+gmDLVgCLkl1zrapWO19OD2H7iWurKa41b3CzfPjmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622816; c=relaxed/simple;
	bh=Tl7XFmDDvPVbUJFGe6rMcrcDTTcoaZn4MNbs4U71N4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aq43+QaegYTd8UUEmXdXKReOO9ryhz/Tb9MMhNFTLHC196/p9jWqm6Itkfk1xdvTa9E4mKXXcuEX1WYtYyiWwzqRR4PBeajBbnllkUwZq5fCxzASdqqTk6kl+DhyUJUWYW6PBXXvN74/Pv58mhVf4J2xf4pQPM8GkhjU2QUgc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JxOLuUvP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720622813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0B/GOXyDiDPobMKu9T39XhvhD9Emiwu5J8K0qpzzRbA=;
	b=JxOLuUvPl7Z9I0Uu6yeL+vC6U8vS9lz37iQiOfjqwgThoekV6C0Gb1wcj5W1O7fbxkCPnI
	BrslXVonzjXOTt+B1d/nFjsoYPs4Fz/y1BC4dEUqY6AjLI9xNYyVRzaKCuVIh3jJyyTTDA
	Vdgg75Q4z3StQhK9xboTUX2ds69kA7c=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-xuxaIAYgO6Spw8tePYZyTg-1; Wed, 10 Jul 2024 10:46:47 -0400
X-MC-Unique: xuxaIAYgO6Spw8tePYZyTg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-25e40fa42ddso1411977fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622806; x=1721227606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B/GOXyDiDPobMKu9T39XhvhD9Emiwu5J8K0qpzzRbA=;
        b=Ibo3rWQAgO/yYUNZpKbfG2F1Zr2YU0INuKhrJ1QVXL52viX15TI47tHo1szOwOxbIs
         MqyLmdpXqGvL20rsp9w3OJBNsxq5XlXCVJ4aU7kN653mVTIEt0OMlUhAQZzneoiitf7f
         aEOX2f/T2vj6HBJFcGFqWywuEo7OFd4SLGtVVCwNQqdlpoxc39+cvsU/yN2vQVH294HH
         eLw199Zwb8xeHybWoFNlReVSgkrxUrTUbq4qk5MISOXYkMS6/u1a9HeZZMA9+17LgbuZ
         Usaw2RTWeX21kThKrhxRCn+oacrnQPcdEIQrwgtHSf+t0USwk7VQprgG53ZrhrhFVD2K
         lM7w==
X-Forwarded-Encrypted: i=1; AJvYcCWuup0dvCTf+dGPh+BTn/anmWRiWLTj+S8W8Cfxchm56Y2bSrPu3sFe2zbU+IRKZFams67mdp8f7JY28lD+2IH0XS2Txoo1uwiY1Sl/
X-Gm-Message-State: AOJu0YxmnVg7ZiJJrXCLcMhUNjKWksM8qXXg9PPPvM1B7NpBSI0bH4/A
	9qOozj8DUY+/tS5t9Gv1Kh+lU3UFEFCluo9GGWGQIb0uOxa6R26fOCZR03r1H6DJmk6jAuDt4ur
	y92lXlH5iQ0h/2xRTKWCTcO1oASyzhf/fJqPfjjBtrP9xhmEdguXdNn33XSY0ow==
X-Received: by 2002:a05:6358:7e14:b0:1aa:b631:bb2b with SMTP id e5c5f4694b2df-1aade07845emr713968955d.1.1720622806516;
        Wed, 10 Jul 2024 07:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0y9zwD/aGVYQuTTBcTiddjmn7jGBDMebvGdtIe8mQ9GpJ1Q6oiwz8/EvOQSuu1JQaMwDGBQ==
X-Received: by 2002:a05:6358:7e14:b0:1aa:b631:bb2b with SMTP id e5c5f4694b2df-1aade07845emr713966455d.1.1720622806155;
        Wed, 10 Jul 2024 07:46:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61baa257esm17481816d6.146.2024.07.10.07.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:46:45 -0700 (PDT)
Date: Wed, 10 Jul 2024 10:46:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org, linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/3] mm: Add p{g/4}d_leaf() in
 asm-generic/pgtable-nop{4/u}d.h
Message-ID: <Zo6e1ILgDn6nuhGC@x1n>
References: <bcd6ab8246348f18fdc77694e321ee6458f05781.1720597744.git.christophe.leroy@csgroup.eu>
 <f69941b076bf8fec89b6bec5573fdb79483c2a75.1720597744.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f69941b076bf8fec89b6bec5573fdb79483c2a75.1720597744.git.christophe.leroy@csgroup.eu>

On Wed, Jul 10, 2024 at 09:51:22AM +0200, Christophe Leroy wrote:
> Commit 2c8a81dc0cc5 ("riscv/mm: fix two page table check related
> issues") added pud_leaf() in include/asm-generic/pgtable-nopmd.h
> 
> Do the same for p4d_leaf() and pgd_leaf() to avoid getting them
> erroneously defined by architectures that do not implement the
> related page level.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: Added pXd_leaf macro as well in asm-generic/pgtable-nopXd.h to cohabit with the fallback
> ---

Thanks.  I'd drop the inline functions, but no strong opinions.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


