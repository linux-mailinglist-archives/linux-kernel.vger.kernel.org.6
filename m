Return-Path: <linux-kernel+bounces-544128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B37A4DDAE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 421F67A6AA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675D020127A;
	Tue,  4 Mar 2025 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuAUhuf6"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E020011E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090692; cv=none; b=fPNi64i5RcyymEKEZIetDFfdfkwHO0M1SffY0rNH5bMsMMV3lKUbZWHf/SDKS42DhZYs53Hje6n8eQnmgrvopd3q4aaXShVMx6aqXY0skhC9Zf6GeAsvqlV1BnQa27RX5PlM4LiI3UOfF/VBgNwMiCCA06iny+Jt+s3K18Hqxpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090692; c=relaxed/simple;
	bh=UQXzM6kTQflqJehh2LcdTlfKHXewkave+srWxXYFSBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnY4Z2nbRJYJErWwIxyzrTR1pUj9LwXjOuV0SJaQyz8u7Yjs3SF+2Mf0aRCvKK2z0PA0vMv7aiTNandfXoj4PEL4UVZgxogsLd/2umXRJmDQ5Msn2tsdEY9iJdlgqb7ReMkvo8jMZsWwzFr1SV8dFpN/GQIxW5J1ELpK3vTGtYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuAUhuf6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so3014343a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741090688; x=1741695488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GU6MTFhK6BSYVwInxWpb8MmgiJb1y2ld5zAqpXaXvFo=;
        b=cuAUhuf6gp+YF/0wjn5Lgk6idvEfVvxZnGYY4lQJUtUUSYGB0bDYvVoZoWkeuDmj94
         UQAtDMluwc9DpsJngc3HuQy2xH4lRRrm062ZOuTmt7lVOaxChluIXwMGvu2dHXFRYJoh
         N4rrGVy7atIKOVVud4ch1dOVI1vZfd8hF+e/TQZDMwV5EUTeBtgdDzYMU3J6I6WO/AB3
         zFiUN4FRCBTsgc8PzqwaBi6/s0MSd3yLkcWlsXzf1vYIMNuX4XUAsnNsRGfN39rXlfwP
         LsbBKgvmtuBcCzzsAQB2kwz6jxCYLgvP3WHpEZanjnFUGi7Ey2Hnk0EiuBCJ/Ddvh1On
         jw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741090688; x=1741695488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU6MTFhK6BSYVwInxWpb8MmgiJb1y2ld5zAqpXaXvFo=;
        b=olQpcIV99zumY9r3ge78Bcg5ePBwqvp7TITryvoUEZnjRDQSU3NAj2yajhddDsAzAx
         1XY6nfHI87yhXm7b8hgo8vJlq+2wQeqWNOjYh+xuAl1cxxWu86xn7in5+eM6qBWqAzRJ
         qwg0H/bOj7t7EaijiZERR9VwmkPvwr8iQN660phIFqZxObyhVWJm5TN4Ej3PXMGrdSto
         H/l3IMdpRKC8s2yFsSkwLvt8LgbzZiXzOzu3UvU1YgotTatzlP8hPMnATn1VRUnYgtNl
         EspCW06X5C5diozvrRCTrkl/jC+t27utwFXnM00LQ4FkUMM8heKb8nRIsGecbrXTIzJ/
         F6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCV+l0hFEU2ZcF3Ae8tQTjALrN8vH27L+T9QaBeB+dPsPFiCoTV0Z8nP4d3AyKjibZIaU+STcHnJrQN0bHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWEPy2Cnlaf53CmXhg33mrk/boDxJ+vZ/XXnGS8AzzNSe11Ka/
	L0GsIs2M9OM4W8xXSNB23gKSCxDyE2SbdA6YnGRFn4tgZWNmCzOp
X-Gm-Gg: ASbGncsS0Qh/ceONdfoKMasv0aq6CPTX/IrpAjg/aTi0vstaDLo1EFvKqAd/juRM+Md
	E0BdBN4SbXBOoH0Y0i7PnAGfTMadRz+guHFAJGwbSrD3XpfRz+ea/Axwf+F6TR6vEjEgrnMgVYd
	YdC5rOGBZxAR/Q6k1icCU70x6Ez9ywgWsqam/MmN2p6pyCEXeIczOkxZnkYJ41aCXLu0eLrPfu6
	J5zSU2yz6+caN5cwmFuv+cyVU8MaQdtlkOI1Q7/+VeM/ujDNecUZxLOmpRn9F/tb6QUn+dfn5Cb
	gOb4uswILjNml/53ttuUdKFOSBG4rHbg5D+vrr5AnNanl6gx
X-Google-Smtp-Source: AGHT+IH2dUnEJRh/KYalyuG0AzKTquAC8pQCaaFSVR9Wv0ldxlyVTaJtY0Ad1L902z6mMNPPL9MFMQ==
X-Received: by 2002:a17:906:f59b:b0:ab2:f6e5:3f1 with SMTP id a640c23a62f3a-ac1f101934bmr328042866b.8.1741090687847;
        Tue, 04 Mar 2025 04:18:07 -0800 (PST)
Received: from localhost ([2a02:587:860d:d0f9:2a79:b9e6:e503:40e9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf439db928sm684864366b.64.2025.03.04.04.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:18:07 -0800 (PST)
Date: Tue, 4 Mar 2025 14:18:06 +0200
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
Message-ID: <Z8bvfiyLelfXskNw@Arch>
References: <Z8Sc4DEIVs-lDV1J@Arch>
 <b951acd4-5510-4d03-8f1e-accf38d909b6@suse.cz>
 <Z8XbomV9WCabATIM@Arch>
 <8cabcf70-d887-471d-9277-ef29aca1216b@suse.cz>
 <Z8a4r2mnIzTD2cZa@Arch>
 <714d353a-49c8-4cbd-88d6-e24ae8f78aaa@suse.cz>
 <Z8benEHigCNjqqQp@Arch>
 <c736fbe1-f3f4-49a0-b230-41f9da545fad@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c736fbe1-f3f4-49a0-b230-41f9da545fad@suse.cz>

On Tue, Mar 04, 2025 at 12:20:03PM +0100, Vlastimil Babka wrote:
> On 3/4/25 12:06, Lilith Gkini wrote:
> > On Tue, Mar 04, 2025 at 09:41:23AM +0100, Vlastimil Babka wrote:
> > -- 
> > 
> > and in the case where we want the code to not display "Freelist cycle
> > detected" we could do something like this:
> > 
> > ---
> >  mm/slub.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1f50129dcfb3..eef879d4feb1 100644
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
> > @@ -1437,27 +1437,36 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
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
> > +				fp = NULL;
> > +				break;
> 
> Since we break, nr is not incremented to slab->objects + 1.
> 
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
> And thus we should not need to set fp to NULL and test it here? Am I missing
> something?

Thats true. I still had the return fp == search; in my mind, but with all
these changes we can just leave it as return search == NULL; as it was,
because we are handing the edge cases.

By the time it reaches that return line it should be fine.

I was also thinking of fixing two lines to adhere to the "Breaking long
lines and strings" (2) from the coding-style.

---
 mm/slub.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3..e06b88137705 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1427,7 +1427,7 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
  * Determine if a certain object in a slab is on the freelist. Must hold the
  * slab lock to guarantee that the chains are in a consistent state.
  */
-static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
+static bool on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
 {
 	int nr = 0;
 	void *fp;
@@ -1437,38 +1437,48 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
 	fp = slab->freelist;
 	while (fp && nr <= slab->objects) {
 		if (fp == search)
-			return 1;
+			return true;
 		if (!check_valid_pointer(s, slab, fp)) {
 			if (object) {
 				object_err(s, slab, object,
 					"Freechain corrupt");
 				set_freepointer(s, object, NULL);
+				break;
 			} else {
 				slab_err(s, slab, "Freepointer corrupt");
 				slab->freelist = NULL;
 				slab->inuse = slab->objects;
 				slab_fix(s, "Freelist cleared");
-				return 0;
+				return false;
 			}
-			break;
 		}
 		object = fp;
 		fp = get_freepointer(s, object);
 		nr++;
 	}
 
-	max_objects = order_objects(slab_order(slab), s->size);
+	if (fp != NULL && nr > slab->objects) {
+		slab_err(s, slab, "Freelist cycle detected");
+		slab->freelist = NULL;
+		slab->inuse = slab->objects;
+		slab_fix(s, "Freelist cleared");
+		return false;
+	}
+
+	max_objects = order_objects(slab_or0der(slab), s->size);
 	if (max_objects > MAX_OBJS_PER_PAGE)
 		max_objects = MAX_OBJS_PER_PAGE;
 
 	if (slab->objects != max_objects) {
-		slab_err(s, slab, "Wrong number of objects. Found %d but should be %d",
+		slab_err(s, slab,
+			 "Wrong number of objects. Found %d but should be %d",
 			 slab->objects, max_objects);
 		slab->objects = max_objects;
 		slab_fix(s, "Number of objects adjusted");
 	}
 	if (slab->inuse != slab->objects - nr) {
-		slab_err(s, slab, "Wrong object count. Counter is %d but counted were %d",
+		slab_err(s, slab,
+			 "Wrong object count. Counter is %d but counted were %d",
 			 slab->inuse, slab->objects - nr);
 		slab->inuse = slab->objects - nr;
 		slab_fix(s, "Object count adjusted");
-- 

I do have to note that the last slab_err is of length 81 with my change,
but it looks fine. If that one extra character is unacceptable let me
know so I can change it to something else.

Or if you think it's completely unnecessary I could leave it as it was
in the first place.
I just thought since we are trying to modernaze I should fix the length
as well.

Also the CHECKPATCH is complaining about the `fp != NULL` that we can
just check fp on it's own, which is technically true, but wouldn't make
readability worse?
I think its better as it's in my diff cause it's more obvious, but if
you prefer the singular fp I can change it.

If these changes are acceptable and we don't have anything further to
change or add I can send it as a proper commit again, But I should
probably break it into multiple patches.

Maybe one patch for the lines and another for the rest? Or should I
break the bool change in it's own patch?

