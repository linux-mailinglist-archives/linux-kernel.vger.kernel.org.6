Return-Path: <linux-kernel+bounces-572117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC26A6C6AC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 01:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAE01B61B2E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BE5442C;
	Sat, 22 Mar 2025 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLrVt2n9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88EF10E3
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742603431; cv=none; b=FjGAma+Xac5mezKeCcfOy5Ep+ajwHZQhPEk5f8nb32GObqEXdA1agM4bqsbL49aEL0bcYiBC/VyJfxkOxUMSPbtlIGd/S+L8Ibd1UcdsIEKZRuCgPIjrV+RNHCgSpADxa44UrWL95kNkig8rui1PSCeggAqqU6JCtRy3jWVmgtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742603431; c=relaxed/simple;
	bh=7SdFDQYeZjv11JLX3MiOymGenvE9jIHe54bGvjM9ZuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgz+ln5Uj4rTE7ylAMPTLVY5yoYpxwfswnuqBC8eDohXAsDvooP9ydJuId1zQH/Tgksl2urIdZQmI2fw37hkzaZBWZlVpCTB2SeaLSfEtiId8D27QJlAQsw/kGDmnE9sXdnup+SvFfQ9QToTeKjTeqnubR6dIXm3qT86EJqsl9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLrVt2n9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742603428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CWlkvk1KBetht7Ag+Rj3C+3gwynOXUnhWtcvGTCPH9g=;
	b=jLrVt2n9uHzHId3mmOFi2Elvb+D6B3tMXdqlAbjPBbLQqwyP5Wrg5krf6WELlxHtLapnZf
	JCkcikUleFRIiY8QWXmIdsM6rIJsMzNX247nxBo4yS6ZiwL8g8V/kwIDd6IyzGsBYY63Xs
	6cQ4SanMyi8aHbkY/DH6+0NV1wICXAk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-Y9GCRZT5M960hwWQwzCs9Q-1; Fri, 21 Mar 2025 20:30:26 -0400
X-MC-Unique: Y9GCRZT5M960hwWQwzCs9Q-1
X-Mimecast-MFC-AGG-ID: Y9GCRZT5M960hwWQwzCs9Q_1742603426
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d44ba1c2b5so24652545ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742603426; x=1743208226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWlkvk1KBetht7Ag+Rj3C+3gwynOXUnhWtcvGTCPH9g=;
        b=qroxAq/CKF1GcGBWOhULshx7P1wp/uBvzw9GERt1Ld/0EREvKe0TUiU1hs/SzUi1AG
         EEz/DYUUVkuUJPcYdsVCPsa9nEbDHIZBj8DvtBs+vLgozbM78UVnXTRoSBumdu/A9Y7F
         ru3r5H6A5qVlciF/Kb9zi7sKbQ/6mnWW3vTimRB60UktNAUjdffmneRiU8VG5CigvNJJ
         CSlAmqoFroKMqk1OwkFEM7617y+cH53Wl6kRoIADQs+fFvIrS4E8MzzM23dSRBpHn5qQ
         EvH/kCFDFk7uwLrp0kLTFq6EZGCc0Vl4JwxkDn24ETe2IyRrNIR2NCVkEcSIXaw5TFqS
         7Qpw==
X-Forwarded-Encrypted: i=1; AJvYcCX027LCebhlquuHWWQdQLRYNI2xLSQwqJi6Qs+UfLujhg+qC9AjB0SmN8Bd3N9rSEeIDwIXNUMb4p0zUQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD8KG9EPDbvzfVfzbcA32x0abjwQBmfi75KE4ZOSIfM+FZYG90
	/OY7H+kZfi7yKo1YQgG/zq4fgmjaF1DR4RtYZW+G1PTWcbIg5CifvxuulVfP3wByTJ3js2Var1C
	oKw7+6FvS6wNmYgGL8iRbfi7/BqrVailvjGEzpeyoxpiMQI22zlEFJ95tfOvm6w==
X-Gm-Gg: ASbGncv2xa1TtQDDVjW5isQLSA0N2GTCGatwxN+ppxotnV9sYuWsc12PMRZweL//Ora
	SzK6ICWGLAGv7x0FJtJ5+/arbkoaHYyai5PVWCUrS6lOCIrwUeFZQCoeKPF8xCtrD5d0C0YztdS
	oSqV0EYodZs+uCe4Yj1QCvYIn3r8YnWZVc9xw9GYXqXpgLbpPiBLsmvVhR0wupz/weaQVPXAgLD
	1z0XEiendmsZ/xhfz5h6hiTVm95VU2MuCvlDSrIMNOjXsPLswjwWvq1NQ8IpKqpqKNy9b8gZboq
	xQ3dGV0=
X-Received: by 2002:a05:6e02:1fed:b0:3d1:97dc:2f93 with SMTP id e9e14a558f8ab-3d596186300mr62395145ab.20.1742603426010;
        Fri, 21 Mar 2025 17:30:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz+fdg6EnsNjYRzuN4tmC+mxNsl6fpbM1aMJ0TwbL+kR0iHWiiNNJUAdfLRTjLeppDFKFSzA==
X-Received: by 2002:a05:6e02:1fed:b0:3d1:97dc:2f93 with SMTP id e9e14a558f8ab-3d596186300mr62394955ab.20.1742603425546;
        Fri, 21 Mar 2025 17:30:25 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdb3aa9sm690364173.17.2025.03.21.17.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 17:30:24 -0700 (PDT)
Date: Fri, 21 Mar 2025 20:30:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.15] mm/vma: add give_up_on_oom option on modify/merge,
 use in uffd release
Message-ID: <Z94EnmSpBO2L-Mv1@x1.local>
References: <20250321100937.46634-1-lorenzo.stoakes@oracle.com>
 <233o4lohzhriye27szk6mucduneuvosmnp6pmnjepz3enxjgtt@id6kwhjgysbj>
 <owmqbntgrnwzbjuyzq7r2it7isqjvskq5svvdiosfd6mjpiowx@gm2lu3gol34x>
 <494b3b71-4331-4365-838c-84974bbed32f@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <494b3b71-4331-4365-838c-84974bbed32f@lucifer.local>

On Fri, Mar 21, 2025 at 05:16:44PM +0000, Lorenzo Stoakes wrote:
> On Fri, Mar 21, 2025 at 11:27:34AM -0400, Liam R. Howlett wrote:
> > +cc Peter due to uffd interests
> 
> Gentle nudge for Peter to make himself uffd maintainer :) I am not a fan of
> this 'happen to know person X often touches Y' stuff, this is what
> MAINTAINERS is for. If you're not there, good chance I won't cc you...
> 
> I also strongly feel we need somebody to take overall responsibility for
> uffd at this point.
> 
> Pints will be bought for this person in Montreal ;)

Thanks for the offer, though I will be absent from lsfmm this year.  I sent
a maintainer file change here, though:

https://lore.kernel.org/linux-mm/20250322002124.131736-1-peterx@redhat.com/

Maybe someone would like to be the 2nd reviewer, and if he/she would be at
the conference maybe the pints will still count? :)

[...]

> > I hate both of them, and I (mostly) blame uffd.  Some blame is on syzbot
> > for exposing me to this unreachable failure. ;-)
> 
> So do I.

I agree with Jann; AFAIU, userfaultfd is innocent, if it used to work.

I don't think I have followed much on the recent vma mgmt changes.  So I am
almost of no use here.. I'll leave that to you experts.  Beers indeed might
help.

Said that, it'll definitely be very appreciated if the old behavior can be
fully recovered, so release() will never fail at such -ENOMEM.

Thanks,

-- 
Peter Xu


