Return-Path: <linux-kernel+bounces-363003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DAD99BC96
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 00:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6D31F2138B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 22:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293E813BAD5;
	Sun, 13 Oct 2024 22:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="qbTzr8za"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E3A231CAE
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728858985; cv=none; b=DPX+BoKiZRk7jbfz1LPEWxlTm2hplhqixW066wDnb+FHeRRNUklhvwmDzdvfzEz29rpyu++0QlViThdkckOhqDmuR4flSxXfwnuC8y+fR+Rjli5O19vRpiMjofzlQ93bObSpy3jHUKUejBnzuHtDXxnoBSNdTEjTLF5mUeQ0OiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728858985; c=relaxed/simple;
	bh=Peb6bcYmsijxQdZrKdqDRK3r6A3NRfXS5629e+5g/1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqkQqOp+vv9Yg9lSU6lMGFiPGlzCkF0ZNC2Nd3dobnfnhkhcN9ljC8wKsslN1+03EfUMfHPY5ZLxHi6epHRvnALVjWDSQ+0klkdFD9NE22xUiyyEnLXwqUTdkkSIDb1JODYLYG+25ZLosIiaTcXlCRNCbnznVQux1qugqhMNxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=qbTzr8za; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728858964; x=1729463764; i=spasswolf@web.de;
	bh=aCw1oeSw8vSXVmoCunY1TVWsQxtjHFr3wh/NLJTUJag=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qbTzr8zajSx1qrBlhxOQaq8a+ttJ31wT+DyOB/WhPiT5nZIJeuAt7LAQxvkrZsQs
	 2/1mSqYTgpQg8JvuTtQLmw+zsciSOP2h7EzUUAV7/mkUE2lWZSGfMCA14dhw3/ar1
	 cM9h8PPdetnzigRVEz1ZN/HIsoO+HiJzzGR6wIF8bFavEXknPgoW3F7pQUcqJoThP
	 NrTvNZtAHp4hbbiMKSL3WfO9N6G4TwmdzlUpEW0kEKqTIbUfZXe9rlqcWhK6LHoXb
	 8yGFCGdff/5bMrnTW1LCVeJBzWMDRY+atHcoCavwRI1daNdiJ9qdq14J3OSQLIuG6
	 dJHg3mWE/FqYWQ2fWg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N45xz-1u05Y23Ycz-012VC3; Mon, 14 Oct 2024 00:36:03 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Date: Mon, 14 Oct 2024 00:35:59 +0200
Message-ID: <20241013223601.3823-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 2394412b-3037-4867-b16e-f155740d062c@lucifer.local
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oeMJEhKzrJsasXR6f69El1Xi2vIV63h9KHEIkU+jCc6RQZyZdDE
 GYMgWEYq0LKPmbmeTATny5/IRV6LpIZissNZ5b4Tg90U54EYVfZ8avPOJO5oCH1uq+n1fq/
 eNj/isjcPAHjZKIZ36v7ChngQFa1vo+XvFlwl5MyG5BfBFlTyyEwRzDy6q13ozaEZUDkBXc
 mYbJYpSmtYSq9s6q2ByNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6HqD0nUwwxQ=;96cZdo5uH9Aug1ItOI7oT9ISc7E
 unzrB9Q39ACym07tq1L6ZCGNPOUgNJWnQQr82ypjP4drK84EkIDbp0slXJ5lgoM/sGdeXKjTc
 nljzvlrlFNstzO/dZ9x/4IzlDB7+5VYa1eblMHOFA35/FRe8lLBAAtgMwyijR4iqT3T48to0Z
 WrifDao4P97DClTKNhj7tcofIZPs4fK6ezia6RPtf3bQ2j639OQdwYQChFDfqxaCLo4aVnnVk
 vBfzG6i/bQVLWECzLG0dwloELo9OW7XjBUF5KxuMtA0IdBd7HNqge/wGyHiNUPvUgD9DX5O+2
 eLHmiSOuMOPsZUwk/ze5NPlk/p6VzhGZHBQFYIQjT3OeS6raydTw3W8UxjZZvWM0y1j09TYpR
 6jakVkIsw4EUsTmM5RaMjmet13+Pmt97ffHEGEkTE5SeIob5IQd1vBqH6bUPWZWXtXuArmPre
 auRFPiRVe7HQXDWUXCxFdJpUeEu26HiXalltK5zpA+oFNIqeNN1aNYNikNIqifaxtxVahDa91
 y6HXkNWqP1TK9wDANKD2fe+8vxQqPBbegEob//UWI/NDK0Fw6qq9ZPICncLOZuqX1Zd8Y8jPo
 0hEPHpJRCNMMTajPXU76LsERdbNDqQDH8dVka74GcPNeln5cvkr4G/trHQ15aGuDPTgE1a9id
 aWn0F3F9FM8xrHirNJigExv2BUpi6sCjoVqOLGromdD/oZAUOqIYZGsKFuT5SmjZPxXBTVEyC
 cP1FfL/2+knAPMAj6LhoO7N/g2e/rmpttnUexDWF7/cx7iy+TbI2zRk3gZLHxeSVjQUoBhATs
 OdF94OTixX/rhcNXZPiZylbQ==

I created a program which can trigger the bug on newer kernel (after the
"Avoid zeroing vma tree in mmap_region()" patch and before the fix).
My original goal was to trigger the bug on older kernels,
but that does not work, yet.

Bert Karwatzki

#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <sys/mman.h>

int main()
{
	int ret, prot;
	void *addr, *tmp =3D NULL;

	// Create a lot of consecutive mappings to create a sufficiently deep map=
le tree
	for (int i =3D 0; i < 224; i++) {
		// We're creating mappings with different PROT_ to
		// avoid the vmas getting merged.
		if (i % 2)
			prot =3D PROT_READ;
		else
			prot =3D PROT_WRITE;

			// These mappings are all at very low addresses in the virtual address =
space so
			// they are mapped before the text and data sections of the executable =
and
			// the library and stack mappings
			tmp =3D mmap(tmp + 0x100000, 0x100000, prot, MAP_PRIVATE|MAP_ANONYMOUS,=
 -1, 0);
	}

	//
	// The maple node we're targetting has the range 0x7800000-0x86fffff (and=
 15 entries of size 0x100000 each)
	//
	//    Here is the layout of the tree before the spanning store:
	//
        //                     [0 - ffffffffffffffff]
	//			/		\
	//		       /		 \
	//		[0-86fffff]		[8700000-ffffffffffffffff]
	//	       /   |	   \               /         |
	//	      /    |	    \		  /          |
	//	   ... [6900000-  [7800000-     [8700000-   ...
	//	     	77fffff]   86fffff]      87fffff]
	//
	// Do we always need a spanning_store AND a merge? Yes, and we must be ca=
refull that we do not merge
	// with the first vma of the next node.
	//
	// This gives a spanning_store because the newly created mapping can be m=
erge with
	// with the last mapping (0x7700000-0x77fffff) in the previous node as bo=
th have PROT_WRITE.
	// No corruption here! Why? This merges with the next node, too! (0x87000=
00-0x87fffff is PROT_WRITE, too)
	//addr =3D mmap((void *) 0x7800000, 0x1000000 - 0x100000, PROT_WRITE, MAP=
_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);

	// This give a spanning_store, but no merge as the PROT_ flags do not fit=
, no maple tree corruption here!
	//addr =3D mmap((void *) 0x7700000, 0x1000000, PROT_NONE, MAP_FIXED|MAP_P=
RIVATE|MAP_ANONYMOUS, -1, 0);

	// this give a spanning store, but no merge, no corruption here!
	//addr =3D mmap((void *) 0x7700000, 0x1000000, PROT_WRITE, MAP_FIXED|MAP_=
PRIVATE|MAP_ANONYMOUS, -1, 0);

	// This last example give the maple tree corruption and the validate_mm()=
 error:

	// The mapping from 0x7600000 to 0x7700000 has PROT_READ, so this gives t=
he needed merge
	addr =3D mmap((void *) 0x7700000, 0x1000000, PROT_READ, MAP_FIXED|MAP_PRI=
VATE|MAP_ANONYMOUS, -1, 0);

	// Just for waiting (to examine the mappings in /proc/PID/maps)
	for (;;) {
	}

	return 0;
}




