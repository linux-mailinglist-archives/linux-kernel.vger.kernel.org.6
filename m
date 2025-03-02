Return-Path: <linux-kernel+bounces-540699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF6AA4B3E5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392A03B13BD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AFD1E5716;
	Sun,  2 Mar 2025 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk+ntxgS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B4179BC
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740938470; cv=none; b=maJFGEenm3hOp+NgIT1ZyjXkOLmaF5CSQ4QEq+oPOUPq7l1lSOQeM/AkuFH0a2fVNApHVXxnti57dneFTktPL1DtbOdszq8cz+Fn43nzX7hwzm+b/VQA+cOWvhZdFPev+JRfimYWd/bPQfNPiqW3hbr0TkA+RDnmK5/GsoYVCcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740938470; c=relaxed/simple;
	bh=FFQFkZBk1rGE/CIyXx/KRQHDFqMs4BE5fS8Iqm+aBSk=;
	h=From:Date:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QYmavlBtnWR8RTyTUZrWtaXuJNoESdB+p+YfgO1WhmQ/+03Ar+SLzTfVKYaPjd3ANB4cUoikCwcMsqr3eNAl9EjbtAS5wKJp9auTkVatMhef4gAL8D4cr1uZQqxRyrCftI8uVKG3u8JvPJvp1AbztTvEAO60QhSUQBp6G4Hihr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk+ntxgS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf615d5f31so165892166b.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 10:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740938467; x=1741543267; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1pO2IRMmN4dez2NTshL35onaa+4/Spjpn9HgFLANMb0=;
        b=Lk+ntxgSWl2rEY4oVCge1wutEfR0Opz5ricx5i+7+2pjnQIVJa158qhLKZPydamZCw
         2U+5fbaBUnbGZ8xEYR2m/vOHMv4pKnhfWbcUpZnB9rv8ECJlvY9JzJhQKI9B+xZZWzeZ
         JJhPewmt2ndBaL3f7M9n1wfSGwV0sf4LjzhmFTEdfgka8rZY5skwo6xSOg8ojDtqfUfv
         bcEyc1umIoV3v28cC1nqU//amIB1Nar6HuYjpLet+8kJq2aA2dr3BguP6N06EgtCR9G1
         MwTPiA4llOrz+6Umgxk71dXUDNxWYHL46GPI+ouQOkrFQm3t26S/U0M4HqQTbDD8LgnI
         GlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740938467; x=1741543267;
        h=content-disposition:mime-version:message-id:subject:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1pO2IRMmN4dez2NTshL35onaa+4/Spjpn9HgFLANMb0=;
        b=GVyAEq8kIop5iMy1vo+299iqhLfT2cc8nQxXC6hN7Ii0BU2/RjquAXtcHFrqLx0CwY
         V5lWXIvqpKQFXzG+oN25pZ3WkMmwHVY0k/LUnpoSbyqChxE6cmtQlDGAw9ibfYe4DDXn
         lzWlWSWucarcccxLwaz4+W0F6N9S3QxwoBzuG0RrljJ2EueOXSH+axEB/YycVF3vAClc
         +sMBGkE1w71qCmfrB8czGblUDSI/g2MmTCRIZTX3FhaBRk4vuNheEGYPa5OAz/2xIWf7
         PemXRjS8p8+zle1S37F9CFrshykHPgEwOPqBcMJehZprbuJvgCp6WEl6vkpOYlshHE6J
         YYrw==
X-Forwarded-Encrypted: i=1; AJvYcCVJtjdmLh2NKXV+1HQ/C/a+a3JOZB6aij4hK6lr4t2HAsvusz3v/9Bf0Og+Yak5V/sA+eP/7BRK5i+egF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdZoGshyaQbLyCO6rzzCtYYyg49jdTySFkKI5hE0ODhxE3elDM
	t/iwmZppf853yDBd6PqZr3najIpYv39VvWVX7/gT1YDXXU+MNs/b
X-Gm-Gg: ASbGncuWwTOzywk/4HpBc7CxkLUM4fEplOYoL2FokdiBiJWLGPpIpGYME+9ixQZnEP8
	eecIKHYXCn/D/4iHtwXeO3f9/DmKBfAvPHv6iZWjmQqaonJsKWhfwnxJrjKG3o5M1Sm66fWplWX
	AWINLh4GSoyPQ/0BookFZY8NhWU/pNVWxuLw7UXR57VRj/57r6IqO+ToB+2pwuBth2ayTgZ/jpl
	0h0+VIMuUgsLYXbU0ECUflnS5AV0BNfi5CCU8X8+5zb85uDythKAwTmNHfYZjneaGkOYLPBWUUA
	dCMuOtvxT6MEvMKeHn0iRKQ3i07QeT+Tez0vGXITDR8/f84=
X-Google-Smtp-Source: AGHT+IGoi6Qa491wgsRww2KUYD6qI0sT4MyrI1EIffk2NCbri74Ktp3AteJARJAzTHWmFEvQRJa6ww==
X-Received: by 2002:a17:907:608d:b0:abf:b2d5:9692 with SMTP id a640c23a62f3a-abfb2d5b06bmr87908266b.29.1740938467242;
        Sun, 02 Mar 2025 10:01:07 -0800 (PST)
Received: from localhost ([2a02:587:860d:d0f9:2a79:b9e6:e503:40e9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf1d1a84b7sm607283166b.19.2025.03.02.10.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 10:01:06 -0800 (PST)
From: Lilith Persefoni Gkini <lilithpgkini@gmail.com>
X-Google-Original-From: Lilith Persefoni Gkini <lilithgkini@proton.me>
Date: Sun, 2 Mar 2025 20:01:04 +0200
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, harry.yoo@oracle.com
Subject: [PATCH] slub: Fix Off-By-One in the While condition in on_freelist()
Message-ID: <Z8Sc4DEIVs-lDV1J@Arch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The on_freelist() uses a while loop to walk through the linked list
freelist of a particular slab until it finds the `search` pattern and
breaks if there is a freepointer in the list that is NULL, or invalid
(fails the check_valid_pointer() check), or the number of objects (nr)
in the freelist is more than `slab->objects + 1`

No valid freelist should have more than slab->objects non NULL pointers,
therefore the while conditional should check until slab->objects amount
of times, not more.

If the `search` pattern is not found in the freelist then the function
should return `fp == search` where fp is the last freepointer from the
while loop.

If the caller of the function was searching for NULL and the freelist is
valid it should return True (1), otherwise False (0).

Signed-off-by: Lilith Persefoni Gkini <lilithgkini@proton.me>
---
 mm/slub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3..0d3dd429b095 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1435,7 +1435,7 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
 	int max_objects;
 
 	fp = slab->freelist;
-	while (fp && nr <= slab->objects) {
+	while (fp && nr < slab->objects) {
 		if (fp == search)
 			return 1;
 		if (!check_valid_pointer(s, slab, fp)) {
@@ -1473,7 +1473,7 @@ static int on_freelist(struct kmem_cache *s, struct slab *slab, void *search)
 		slab->inuse = slab->objects - nr;
 		slab_fix(s, "Object count adjusted");
 	}
-	return search == NULL;
+	return fp == search;
 }
 
 static void trace(struct kmem_cache *s, struct slab *slab, void *object,
-- 
2.48.1


