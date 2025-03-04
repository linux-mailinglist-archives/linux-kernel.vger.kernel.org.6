Return-Path: <linux-kernel+bounces-545145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A3A4E99A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299EF424156
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321FA29617D;
	Tue,  4 Mar 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVWwZqUa"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B389B2512E8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108476; cv=none; b=eOUHZs1WNH8C/jClo28p1geYAGZQjWVheTU24Ggr2mnHB7cyrXTkjI8REiE46cK3PjxohzZDGKGOkQqyTCBKhNnYDR2IybtN1u2GMNfa36g4c9QyW4Wh+DRIA5NtPMuIFoYoTlt3Dv07fJFoq5Z1FjfZUOio0wvCRCdDYrXXH7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108476; c=relaxed/simple;
	bh=8hCAyFKwwmkX/8YHCYOFpHWiEtIkXevzscP/J2gTrJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyZkxz/sKJ0tu4dOHSG46arIx7GcDPrvsiiFXkLuHHJYDyUyQpJS9ZNmPHFK8VfmZhy65skVfL3ICPilVtsp6wuYVRr/B0ll3uSt8Q/qsQAaCqOhjXaDto47wnqtihhquU2wIkFlUbm+SlhQQCsDbBhNx5IFEXjm1yqct06qDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVWwZqUa; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e51e3274f1so6428349a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741108473; x=1741713273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PhODX1MZG6aDPWMLZOZeLQ4jZH5jv4ycal+F4TYo1r8=;
        b=OVWwZqUapPXIx0kHeWlRMfpaVNVkN8f0LtVwigXnZ4vJqNt7/LfDJvojGvjwIoTV5d
         o2EvkkPVF3Ey1rTsOULzerPM9tF8zkmkdSLLXDSX4Vz7wDeRPWj8pqq1vGZdsDDIxRN7
         aWDAA0isft3JTwdIsLXxmU+DVIBiklMTf0Ku//o+n7nPd1gqFoEllVE5Qr8c5SBd6g+i
         eQf30z2mNObDrkK157AFkPDIXiui54Pm2o/EevxGN4sL//LMqVBZsOZRTl0yzEuQEdLO
         Ku9kSLDJkkMmo44RYv/pz5KrDhTpvMEc2Kh+Js/iKt4DmAgeEaztpjzY3mngC//D/GRl
         5ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741108473; x=1741713273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhODX1MZG6aDPWMLZOZeLQ4jZH5jv4ycal+F4TYo1r8=;
        b=p/FNnbPWDQ4SCkzBDDOC/EzW61VdpFgeXdrU4boqlLtYJkpnGmNICXLcT3G13FsU19
         ThKrT1xXLPKwn6DwM4DLFrlFvK1aO9r1JMPIUKuDmIS7Oo2ji/AZY6W5UgBxSgxgxK5P
         ArTH1xKMw7lne4JbhzELoHfGQ31hQu9yAtLOSVbBAeCGM3hT+SMLrtKHQ1Xm7WnmUfeE
         2G89M8qTGsXOOIJtPExFlvegC2RM3af+JCENhcDuVF/WJ3WKgFFxBBdXdun++RSPiWF/
         /96N+WZQtMRyF/stx5kLSraM1Ult7YdLNpefSiucqvABoOXt0S0eKaU1zXUCtNCFr7bB
         enSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUx3h80dKGYr2/44pvgPUdEUsBvttLVmFDYdHG2IqqtzjXvGCuEEw7MeTKSPjTeLwLJiHiDYzubsSqahs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhgPxX4sJ0O6ytkJUzrjp3o1Igt/auOhe9ms5W8z9M03L4Hwv
	sN/6+iSRT3GAEfSEGZ1rOLEGp5ZHj3OInUgl8wSpkyCcresmGgRD
X-Gm-Gg: ASbGnctGh8kPiud+7fteSDn0uOvo54r/JQpeiztWvwIUV679ndZsEA33XvZSayH0YMh
	FVvYaPHAKLnp8zXbXvCXzfsjlFpaIiKG+d+FoV7qQMBp+HpI/f/0TtVr96koD3pCu1lxUJOha0l
	82Ckrm2fPOqBIWz40Ln1PzGVtysMWtvwUe/qghJW+L+/zBaSCnGEpAGbWKY62pYOQ5hFczQj8h6
	sX9l9hJJii7qEu8dGNiPm4eMoaBQIRnSkcmrjdb9ttsUkQNGHlniheQRBpoU/Cfk+0aOENx7DOV
	tHnuIJBQ0g0c5CxQhBa1OC/+nXoFLHukn+473zoA/NTA48te
X-Google-Smtp-Source: AGHT+IGNKGu21kO4mZSLA8+Gs1TnQhcvM1dkVhhaK4YPE9KLLc02MJoQfkLH1KOPsM01F9x/VW0Cgw==
X-Received: by 2002:a05:6402:2350:b0:5e0:8c55:536 with SMTP id 4fb4d7f45d1cf-5e4d6ac9e59mr19010240a12.4.1741108472494;
        Tue, 04 Mar 2025 09:14:32 -0800 (PST)
Received: from localhost ([2a02:587:860d:d0f9:2a79:b9e6:e503:40e9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e4c3b6cfc4sm8458585a12.18.2025.03.04.09.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:14:31 -0800 (PST)
Date: Tue, 4 Mar 2025 19:14:30 +0200
From: Lilith Gkini <lilithpgkini@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, harry.yoo@oracle.com
Subject: Re: [PATCH] slub: Fix Off-By-One in the While condition in
 on_freelist()
Message-ID: <Z8c09l1crlboL8Tf@Arch>
References: <Z8Sc4DEIVs-lDV1J@Arch>
 <b951acd4-5510-4d03-8f1e-accf38d909b6@suse.cz>
 <Z8XbomV9WCabATIM@Arch>
 <8cabcf70-d887-471d-9277-ef29aca1216b@suse.cz>
 <Z8a4r2mnIzTD2cZa@Arch>
 <714d353a-49c8-4cbd-88d6-e24ae8f78aaa@suse.cz>
 <Z8benEHigCNjqqQp@Arch>
 <c736fbe1-f3f4-49a0-b230-41f9da545fad@suse.cz>
 <Z8bvfiyLelfXskNw@Arch>
 <c99235b8-3859-42dc-988b-250b3f042d00@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c99235b8-3859-42dc-988b-250b3f042d00@suse.cz>

On Tue, Mar 04, 2025 at 03:25:26PM +0100, Vlastimil Babka wrote:
> On 3/4/25 13:18, Lilith Gkini wrote:
> > On Tue, Mar 04, 2025 at 12:20:03PM +0100, Vlastimil Babka wrote:
> > I was also thinking of fixing two lines to adhere to the "Breaking long
> > lines and strings" (2) from the coding-style.
> 
> Hm AFAIK checkpatch was adjusted to only warn at 100 lines. While the style
> document wasn't updated, we can leave such a small excess with no change.

Yeah, it didn't complain about it, I noticed it while having multiple
windows open with the diffs and all.

> > ---
> >  mm/slub.c | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1f50129dcfb3..e06b88137705 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -1427,7 +1427,7 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
> >   * Determine if a certain object in a slab is on the freelist. Must hold the
> >   * slab lock to guarantee that the chains are in a consistent state.
> >   */
> > -static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
> > +static bool on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
> >  {
> >  	int nr = 0;
> >  	void *fp;
> > @@ -1437,38 +1437,48 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
> >  	fp = slab->freelist;
> >  	while (fp && nr <= slab->objects) {
> >  		if (fp == search)
> > -			return 1;
> > +			return true;
> >  		if (!check_valid_pointer(s, slab, fp)) {
> >  			if (object) {
> >  				object_err(s, slab, object,
> >  					"Freechain corrupt");
> >  				set_freepointer(s, object, NULL);
> > +				break;
> >  			} else {
> >  				slab_err(s, slab, "Freepointer corrupt");
> >  				slab->freelist = NULL;
> >  				slab->inuse = slab->objects;
> >  				slab_fix(s, "Freelist cleared");
> > -				return 0;
> > +				return false;
> >  			}
> > -			break;
> >  		}
> >  		object = fp;
> >  		fp = get_freepointer(s, object);
> >  		nr++;
> >  	}
> >  
> > -	max_objects = order_objects(slab_order(slab), s->size);
> > +	if (fp != NULL && nr > slab->objects) {
> 
> In case nr > slab->objects we already know fp can't be NULL, no? So we don't
> have to test it?

...Yeah. All these different diffs got me confused. What a mess.

I just tested it in a debugger. That fp null check isn't necessary.

I'll send the full patch tomorrow or something, when I check it again
with a clear head. I dont want to do any mistakes in the actual patch.

> > I do have to note that the last slab_err is of length 81 with my change,
> > but it looks fine. If that one extra character is unacceptable let me
> > know so I can change it to something else.
> > Or if you think it's completely unnecessary I could leave it as it was
> > in the first place.
> 
> Yeah can leave it.
> 

Alright, I wont include the line breaks in the patch then! I'll leave it as it
was.

