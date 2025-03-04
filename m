Return-Path: <linux-kernel+bounces-543954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 028F9A4DBC9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C731889AB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456141FCFF4;
	Tue,  4 Mar 2025 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mzm3cU6W"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B327273FE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086370; cv=none; b=fTSDpAVmRiIDsWYXHCWBluYU599J2HsWTqlqZTFhji0ieuxHU46LEZasao5furEH3nbTWJBMTvz/1HsRVcQfWEBfWS7O9e7wuZ9O6seciSkqU+1bAz2WdrN2ZLn9k6e/FbxTuetCijyC7ZyjB13Vh+clrq7cFSaeqNXhygnw72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086370; c=relaxed/simple;
	bh=n6sA1w071I4w+sXe9VZkyvguq3G8sDdnB3R3XfhJsrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMzrH/j15u/baJQxa9fEtTQurTBLC9lSmSV/QUvaIMJZwRpihrnxOh9jAVaW4fYi0s5qj3wa+SAvobtGberY48+lohmQVp0dOqw6HcZanNZvLb3umanrcf71sQ3pSg0+3SDSNw5I58vTMMvhiyHibtymOlSQ3Z7USto41AzkxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mzm3cU6W; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e55ec94962so2966802a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741086366; x=1741691166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxvndgwv4ifV3uRHMIkq4wSTyXoMRUAEuK9dHeEk0yg=;
        b=Mzm3cU6WRG7dMqPbw9Rlry4WDhFelBf/r2tQeIKQDn4x5lO3cE0lJQGL66ha5eiWfG
         X1JO9jH7HM/yqE+5Fw5nNNF/9X2FdRjPmWF63O6ZtFO0K8Nq9RmUs1UCFomex7g9bqFb
         Nl5M0UbPEetUESSH5hItDphGG3cSVt5q2lIDWWhn73bk1rTfZ4M+9oJkVlKVmKhA0Y2Y
         Y5qVE7rZfhvjB7rGlRT3pmqDDYvHv6hkqM7eAfkXwQWGvXofwpYII7i+yvfJiY8Qv8Fg
         6y+dL5xss5d72lCWRzq+Hb7l34RxhJJMIS11QLaK/jzd4F8vARyGvTny99q0V3+FZGjw
         gqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086366; x=1741691166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxvndgwv4ifV3uRHMIkq4wSTyXoMRUAEuK9dHeEk0yg=;
        b=PFK0cz5LtVcPE2e3y3Qprd9lOKqh2cMBaoule5PeHCr+cRaSIV0KwVNAe/vE7ERXGs
         IdEvWF3XWYbLR5aoBRsCewCfLLaVVOFyBAJMjHNCPRkIHQaGcJT4s7s2mCO69TvBu6I9
         44ce2x6iWYJnU/HRy2VgM0JSlT4uG1KbcnoL6S77JU17VKeYZPoyzXCbFPVncP96gWuS
         7naGTS4Qk6di60Wwx1nH6lgwHc9TLGqT3TIzU3m61JwB0nt3QIzjC8rUsq5au0og5nQz
         J+iNxMjdc1gnULlieoDCiHgbIH7vE14Jf+QPxsD7uELm6APGhlq2pMRh7C9NC063sLkv
         Fo+w==
X-Forwarded-Encrypted: i=1; AJvYcCVg9TJoUI60Xgs8Etbk8HhZg+KBQ1HrPJPlCLHbomAUi+r5D2ft9KxubP+eQIfVxbHAVaVGDmeaTVpySo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMzmc8X8vzzfAbl53nUWNFzb/QgBpBu4E02SgVIYxFNbYGVYzJ
	1qeFm+k+LtbGvhSRzKefg/0Cnj6zXqQdr3j4t93/hJHSvNg59i82
X-Gm-Gg: ASbGncshPX97ckhDrB0baZgGAeTzgLMhTH5zSCQjOW2erni+MqYU+sosFQ4CSzUvNvA
	wgIO88U7gHuR9HjrZabs8XswDrbGdfoU3d/NN8QSmSPxAbwre+fWap0ATdzzVZaNpYGVRpmM3QK
	pKHLeo4ooYiTBUTdcuLMA7MAfiYVe+GBO3m+2frYWAxq1DphMYpfD7doNiK/MYORfXkm32FcTHX
	3f3hwR7ESkMDzI2v+rhaMfjj52dtmhjT0KLuSVXM31ST4aLO/Rr43V1Cqff5x8Kb1ZiGHMYr4AR
	HsyIy0QASfz/3amSos9aBjm6DzCtoZbgnc4sR8lvOzUnWd0n
X-Google-Smtp-Source: AGHT+IHKQCxTrixvTJRNOXl1k412tIdlU/Fx3nbL1YBSRrSigkz1sJpeABuqT2KoL02ZS9AZ0iyq1A==
X-Received: by 2002:a05:6402:210a:b0:5e0:69b3:441c with SMTP id 4fb4d7f45d1cf-5e4d6b6906fmr16381942a12.26.1741086366196;
        Tue, 04 Mar 2025 03:06:06 -0800 (PST)
Received: from localhost ([2a02:587:860d:d0f9:2a79:b9e6:e503:40e9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e4c3b6cfd0sm8055619a12.28.2025.03.04.03.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:06:05 -0800 (PST)
Date: Tue, 4 Mar 2025 13:06:04 +0200
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
Message-ID: <Z8benEHigCNjqqQp@Arch>
References: <Z8Sc4DEIVs-lDV1J@Arch>
 <b951acd4-5510-4d03-8f1e-accf38d909b6@suse.cz>
 <Z8XbomV9WCabATIM@Arch>
 <8cabcf70-d887-471d-9277-ef29aca1216b@suse.cz>
 <Z8a4r2mnIzTD2cZa@Arch>
 <714d353a-49c8-4cbd-88d6-e24ae8f78aaa@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714d353a-49c8-4cbd-88d6-e24ae8f78aaa@suse.cz>

On Tue, Mar 04, 2025 at 09:41:23AM +0100, Vlastimil Babka wrote:
> On 3/4/25 09:24, Lilith Gkini wrote:
> > On Mon, Mar 03, 2025 at 08:06:32PM +0100, Vlastimil Babka wrote:
> >> Yeah, I think bools were not used initially int the kernel, but we're fine
> >> with them now and changing a function for other reasons is a good
> >> opportunity to modernize. There are some guidelines in
> >> Documentation/process/coding-style.rst about this (paragraphs 16 and 17).
> >> int is recommended if 0 means success and -EXXX for error, bool for simple
> >> true/false which is the case here.
> > 
> > Oh! because of the emote I thought you were being sarcastic that I didnt
> > report it properly.
> 
> Ah, sorry about that misunderstanding.
> 
> > Thank you for clarifying! That should be an easy fix!
> 
> Great!
> 
> >> > When it reaches nr == slab->objects and we are still in the while loop
> >> > it means that fp != NULL and therefore the freelist is corrupted (note
> >> > that nr starts from 0).
> >> > 
> >> > This would add fewer lines of code and there won't be any repeating
> >> > code.
> >> > It will enter in the "Freechain corrupt" branch and set the tail of 
> >> > the freelist to NULL, inform us of the error and it won't get a chance
> >> > to do the nr++ part, leaving nr == slab->objects in that particular 
> >> > case, because it breaks of the loop afterwards.
> >> > 
> >> > But it will not Null-out the freelist and set inuse to objects like you
> >> > suggested. If that is the desired behavior instead then we could do
> >> > something like you suggested.
> >> 
> >> We could change if (object) to if (object && nr != slab->objects) to force
> >> it into the "Freepointer corrupt" variant which is better. But then the
> > 
> > We could add a ternary operator in addition to you suggestion.
> > Changing this:
> > `slab_err(s, slab, "Freepointer corrupt");`
> > 
> > to this (needs adjusting for the proper formating ofc...):
> > `slab_err(s, slab, (nr == slab->objects) ? "Freelist cycle detected" : "Freepointer corrupt");`
> > 
> > But this might be too much voodoo...
> 
> Yeah it means 3 places where we check (nr == slab->objects) so it's not very
> readable.
> 
> >> message should be also adjusted depending on nr... it should really report
> > 
> > I m not sure what you have in mind about the adjusting the message on
> > nr. Do we really need to report the nr in the error? Do we need to
> > mention anything besides "Freelist cycle detected" like you mentioned?
> 
> I meant just the Freelist cycle detected" message. As "nr" equals
> slab->objects it's not so interesting.
> 
> >> "Freelist cycle detected", but that's adding too many conditions just to
> >> reuse the cleanup code so maybe it's more readable to check that outside of
> >> the while loop after all.
> > 
> > If the ternary operator is too unreadable we could do something like you
> > suggested
> > 
> > ```
> > if (fp != NULL && nr == slab->objects) {
> > 	slab_err(s, slab, "Freelist cycle detected");
> > 	slab->freelist = NULL;
> > 	slab->inuse = slab->objects;
> > 	slab_fix(s, "Freelist cleared");
> > 	return false;
> > }
> > ```
> 
> Yeah looks good.
> > 
> > What more would you like to add in the error message?
> > 
> > In a previous email you mentioned this
> > 
> >> >> I think there's a problem that none of this will fix or even report the
> >> >> situation properly. Even worse we'll set slab->inuse to 0 and thus pretend
> >> >> all objects are free. This goes contrary to the other places that respond to
> >> >> slab corruption by setting all objects to used and trying not to touch the
> >> >> slab again at all.
> > 
> > If nuking it is how we should hangle corrupted freelists shouldn't we
> > also do the same in the "Freechain corrupt" branch? Otherwise it
> > wouldn't be consistent. Instead the code now just sets the tail to NULL.
> 
> It sets the tail to NULL but then also breaks out of the loop (btw that
> break; could be moved to the if (object) branch to make it more obvious) to
> the code below, which should also set slab->inuse properly. So the result
> should be consistent? In that case we're able to salvage at least the
> uncorrupted part of the freelist. It's likely corrupted by a use-after-free
> of a single object overwriting the freepointer.

Yes! You are right!

I also just tested this. The "Freelist cycle detected" will get
triggered even if there is an invalid address at the tail in the case
of a full freelist, which is a bit... inacurate, right? It's technically
not a cycle in that case since the freepointer is invalid and it doesn't
point back to the slab.

- We could avoid this by nulling the fp in that case (as I suggested in v1
in previous emails) inside the "Freechain corrupt" branch, but also
reverting the while condition back to it's equal sign like it was and
then changing the new if check to:
	if (fp != NULL && nr > slab->objects) {
but it feels a bit messy.

- Or we could just change the "Freelist cycle detected" message to
something else.

- Or we could leave it as "Freelist cycle detected".

This is only a problem if the freelist is full and the tail is junk.

If the freelist is not full the code will act as you suggested.


If this is becoming too hard to follow I'll include the two diffs.

For the case were we are fine with the "Freelist cycle detected"
message, even in the case of a junk tail:

---
 mm/slub.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3..25e972a3b914 100644
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
@@ -1435,29 +1435,37 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
 	int max_objects;
 
 	fp = slab->freelist;
-	while (fp && nr <= slab->objects) {
+	while (fp && nr < slab->objects) {
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
+	if (fp != NULL && nr == slab->objects) {
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
 
-- 

and in the case where we want the code to not display "Freelist cycle
detected" we could do something like this:

---
 mm/slub.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3..eef879d4feb1 100644
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
@@ -1437,27 +1437,36 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
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
+				fp = NULL;
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
 
-- 

Let me know what you think!

