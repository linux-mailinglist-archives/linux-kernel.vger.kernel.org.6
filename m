Return-Path: <linux-kernel+bounces-174481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4079C8C0F5F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C00B23173
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22DF152196;
	Thu,  9 May 2024 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="V/0hlFlh"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C3914D297
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256541; cv=none; b=Tc4EBjFzyg/bWMMVmk7E0M2Slcn8PqA+0IvXqPU0uoxx0Z6qU0LUHqcYDJoAU9ZR/nqjVLlA3CYQD3Zy3WUyO4c08xIEXi2R7l7EzY0jqYqfK5Mu0M5URobp0iGZ3s6ws/EArsDl9Co8J38Qr+/OcLWOqSAq0FQqXm4y3PsL56s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256541; c=relaxed/simple;
	bh=MheGQE/mJWoO4vRhqhUVOcqkrd5yQj8kOf03Ylf9vEs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uBCmEjfrFecFkey1lK7fvKFGyZwNzZlu86BPkoyNeI7S/ar0mDAS5WVdF83dAtTT1rSlFi1LbWsQVxK0HvesgawzSTmn8eio6ub1ULkBo+eWn5etRdo1t4dKULf92pdI9AM/uFoZNDXWpIilPrOJI762WVNqjDBZ0zgVV0GLCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=V/0hlFlh; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=jmn3ELwSO3SoaQE9A/DU9RdheTNewmzS+o05cKdEnIc=; b=V/0hlFlhP867wZxl
	Oc7CTsJrHy7I0PYqfbnmc78cXOuYHE32ZyZ/RBjx5b9T9aINeUmAujQFgH7mN2s+9vcNUs3UiHJQ8
	PRy7+rD11n/q+sDUvB64+1Q+VxbNsdzBU4W7JZwFGPfxxJemws+M0ll9iZQly/aqwcu822huF9kUF
	7v2g3CU61fOCeUQ+mhOYbYakWs++zeWdMg5ZF5TGh40sXaogC9qJGqan0MFaExhsE3/fBd/gqUyuy
	frb0D34Usx0M8xB+6sgvrAvLqi1r5CUNeBplDWqeYA+gXX4MAuVAxGPs+ehz8t2I1Qtju4nbu+RaF
	Rgh/gX+kPYo29Ytblw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s52a0-000BVP-1g;
	Thu, 09 May 2024 12:08:56 +0000
Date: Thu, 9 May 2024 12:08:56 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: linux-kernel@vger.kernel.org
Cc: keescook@chromium.org, nathan@kernel.org, luc.vanoostenryck@gmail.com
Subject: thoughts wanted on dead code hunting?
Message-ID: <Zjy82Ja6G2iIHl75@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 11:29:50 up 22:43,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,
  I've stumbled into finding various types of dead code in the kernel
and am after peoples thoughts and suggestions.
  Apologies if this is a bit long.

  It started off after I noticed an unused LIST_HEAD in the parallel
code, so I sent some patches to clean that and related code up
(waiting review!), but then wrote a hacky script to find more
(and then mutex's); and there's a handful of patches removing those
on list (please review!).

  But then I noticed associated with those were some unused structs;
so I went struct hunting, and that's where I've got a problem.

  That's found me ~200 candidates; where I guess 150ish are probably
real; but my hacky script is, well trivial and hacky, so they each
need eyeballing, then a git lookup to see why they're unused, and a
compile just to make there's not some subtle macro somewhere.

 ** Questions:
  a) Can anyone think of a better tool than my script (see bottom)?
   The simplicity is a blessing & a curse - it doesn't know about
   #ifdef's so I don't need to try lots of configs, but at the same
   time, it can't tell if the struct actually gets used in a macro
   and I have to eyeball for a struct which is assigned to as
   a variable at declaration time.

  b) The dead structs are all over; so they've mostly been individual
  patches rather than a big patch series - how do people feel about
  another 150ish similar patches ?

 ** other Thoughts
  * The dead code is all over; from incredibly obscure drivers, to
   common stuff like ftrace and iscsi.

  * Most of them seem to be the remains of previous cleanups or
   refactors where someone has removed the function that used
   it but forgot to remove the list or struct.  Sometimes that happened
   prior to the first commit, so it's always been dead in the tree.

  * There's a few cases where people have added 'static' to a variable
   to cleanup compiler warnings, but actually they just needed to
   delete the variable.

  * A harder problem is unused structure members; some I've spotted
   by accident, some follow from what else I delete; e.g. if you
   delete a LIST_HEAD, there's a good chance there's a struct somewhere
   with the list entry in it that's no longer used.

  * It's not just the kernel; I've just mopped up a few struct's in Mesa
    as well; but different coding standards make the script harder in
    places; e.g. X uses typedef struct... everywhere so then you have
    the problem of hunting the use of the typedef name.

Anyway, that's way too long, all thoughts welcome.
(Reviews, even more welcome, as they get merged I'll work through my list
for a few more).

Scripts below,

Dave
(I've cc'd a few people at a guess for people who might suggest tools;
but please copy in anyone else who might)

* hacky script for finding unused LIST_HEAD

  (ie print a count of times the name of the list is used in the same file;
   if it's 1 it's worth looking at)

ag 'static LIST_HEAD'| sed -e 's/[():]/ /'g |
while read FNAME LINE STATIC DEF VARNAME TRAIL
do
echo ">>>" $FNAME ' : ' $VARNAME
echo -n "Count: "
grep $VARNAME $FNAME | wc -l 
grep $VARNAME $FNAME
done

* hacky script for finding unused struct's

  (ie print a count of time the name of the struct is used in the same file;
  only bother with .c files; doesn't spot assignments to initialise the struct
  on later lines, gets confused by struct's with short names etc).

grep -r '^struct [^(=]* {'| tr ':' ' ' |
while read FNAME STRUCT NAME TAIL
do
  echo "$FNAME" | grep -q '[.]c$' || continue
echo ">>>" $FNAME ' : ' $NAME
echo -n "Count: "
grep $NAME $FNAME | wc -l 
#grep $VARNAME $FNAME
done

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

