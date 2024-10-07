Return-Path: <linux-kernel+bounces-353897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DBF99340B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5B41C23A5B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6ED1DE8BE;
	Mon,  7 Oct 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="OHCVTyB+"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15431DE88C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319824; cv=none; b=OPGJre4s0AoKpONKvCnVie63gThEA4VlhPoYLLlvvfgUXoP6blRhMKf+/zu6KT3f803/r7hcnMMsysPidVva0dMh7USZCFeKO0h205N6YtujV1k/qhL3uUgqY6/mEFyruU9ISi45gpDxU8Uw1vuJUdZyEurhj2+go/9kwgBYEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319824; c=relaxed/simple;
	bh=kpSTiJ+Z0HA7OvW1OVKuK87CY7Sy3Va+gYX0WY2Z+yo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LSLj1f+839RrSwTUbORtoC3/qvbUSi+xIIgH8mBujbB2ZP2bUjENhuDS6mFFl5NuPXTkUSPlB+c6x0tGKkhlfHgRKf1Bn0D978xqs+U5Wa42ljGwFWKXVM6Dl+dFY4MUOVDnEJy4xJXGA26sHzFf3LyOV0pikVb6t7lruz/Ha2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=OHCVTyB+; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1728319239;
	bh=kpSTiJ+Z0HA7OvW1OVKuK87CY7Sy3Va+gYX0WY2Z+yo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OHCVTyB+Azk+B8n3ZOFKzBLY/yorV0hO1+LDnuHJYRSwIF04fBfBJyB7cP+8qQkSk
	 nSWgzqBVVVS7p0+YU//UUZAwnTMQZG0l7ids1Oiu08zNocKbvFkFQFFYiQ5a2STsuW
	 AResWtYR2D8fj3UEMy27SR70EyLWrqTMgzY7zTFs=
Received: by gentwo.org (Postfix, from userid 1003)
	id AF5D640672; Mon,  7 Oct 2024 09:40:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id AE25240264;
	Mon,  7 Oct 2024 09:40:39 -0700 (PDT)
Date: Mon, 7 Oct 2024 09:40:39 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc: Vlastimil Babka <vbabka@suse.cz>, "yuan.gao" <yuan.gao@ucloud.cn>, 
    penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
    akpm@linux-foundation.org, roman.gushchin@linux.dev, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/slub: Avoid list corruption when removing a slab
 from the full list
In-Reply-To: <916bea8e-0e79-c561-f8e8-b3c7fa026161@gentwo.org>
Message-ID: <006695cb-368c-9afc-80b5-29338e85ab99@gentwo.org>
References: <20241007091850.16959-1-yuan.gao@ucloud.cn> <b304fe39-4fcc-4b2b-a95f-1bb476c94a01@suse.cz> <CAB=+i9T4nGJAQGpYSbAvyyfgceLmO6ih=gS7bPpvCdMMetTurw@mail.gmail.com> <916bea8e-0e79-c561-f8e8-b3c7fa026161@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


list_del() in remove_partial() sets poison values for next/prev so there
should no list
corruption but a failure showing the poison values.

static inline void list_del(struct list_head *entry)
{
        __list_del_entry(entry);
        entry->next = LIST_POISON1;
        entry->prev = LIST_POISON2;
}


