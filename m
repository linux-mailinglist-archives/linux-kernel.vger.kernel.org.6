Return-Path: <linux-kernel+bounces-185499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5D8CB5EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 00:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB24282DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DEF149DFC;
	Tue, 21 May 2024 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9xOjNQK"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586431865A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330078; cv=none; b=nERaiCKjOOqBnlTWi8uRqZ3+jD7foufLmIPi3pc1sGQ2s+grndeAPHr2oWNHN5aWHYbKlJBc6nVn0VtI9pr1j33wWxlfWxU4Ombk0aA3RC+iAxeu9vJ/puTbNnTG2kSh2X4UibnuabIEF5afQVcYZGjOZXcTbaykfLlyPB28WUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330078; c=relaxed/simple;
	bh=YpG+JWTZB/2PwhaUNwjmLEazgti0WeMIsrmJUU0okh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EM9q3K/ubwu8yqBHXa7hknmiaQvfLDbUu2dZZBtk2vOCw2B8gSTKQSoIV5x2x3MITuV0XGma+rJCoZR8p0UPUiyZ9Nk9zmyzVKwm9Y0KQLEpILPGvrIFRXp3kwwXwBDzFsKXmHAqqf4RK57loCRHhkREhi+2yPgrnkUdX2thnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9xOjNQK; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43dfa30c4c3so5940801cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716330076; x=1716934876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWatbwj/IWi1yLtM5x+DhOm7/0gMUC6oEuIDN8i47VI=;
        b=V9xOjNQK9E16hDKUiUz2r2lwU+OQZg9sLd4rP0vTgZu110K+Aw3WA3suADL1jEDNf7
         WhAv1Ud3SHqfLSncBycT2P+JzT+xrNb7HZKeAh/hFZOP2pqloyb7ob/X6WNdR26swWe8
         3DiNugOAksvkQ1toStj+4tpanBj1T9rg+YkcA/wTYoXoQN29PRK9A0zyhH2/puetodIE
         TkQPL5A2B6FwJg7jF4J4vQX1UasCs8gSOk1kD/fi7t+e/iMH1g6kqLfWhXF9iQCGaw0a
         czdN7J7WSsgN8kskDJRDo54TzIYgdcoMICqaHsw6vn+qCbBv6xlXrr1doiBouVGNXVTq
         1sXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716330076; x=1716934876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWatbwj/IWi1yLtM5x+DhOm7/0gMUC6oEuIDN8i47VI=;
        b=eqtThfB4BhaMamoDdHckOTk/Tl6um+xEnYGApDW8dWnAhZLrhWhG1jJMIWAzseIqsF
         kgsG+8xb0mAe/VNOi0Kc1RbBUsEf2hGTrAol7J0bCYo6lsnTueseqw3BgZOaTIXvaQlU
         2ibcQnYR+x0r3hwJLFFMQfkMm6nBH87+gwVYlcM8Sb3/biGDH2gZlEUKMowH/Z549DrD
         1/dC5khDC0J6+7f4w+LkKPHD4z6jnGJZ8m6EeZVudW2vBIM6y06iQkhrntmpSWaMRgun
         I7jDF4unrYXZGqNlzJmTfLbQdkURu6bIlvTiiSdtDvtVCFJM3yccXcXkY/q9IDgB0BXr
         acfA==
X-Forwarded-Encrypted: i=1; AJvYcCXRgzAEapRvuYC0Rrp3kQzzH+REYrDroMQzYAP2P3Y7zhPRF9SKequBpCYKk2zFh5soY5bmNCR4pIbtA/MvutOD5oZJNqIaCbhN1Q3V
X-Gm-Message-State: AOJu0YyQKW6QvDUW2OPNtDmsVXKCF8ZOffLS4VqtrcSmMTVYzTqt6Txg
	Xf71jPMyPHdzytvRSVCqBOI9JVzeSOebB40O25T0IrlWeJuX/feBTC8aNdP/9IU0VRxWU6qCpBH
	56xY3c9rW+YaoU34F8gwgO1oq8EIgst+eKFpnGJlVEKE=
X-Google-Smtp-Source: AGHT+IE5zNezKJaapVTDNaEs9n0NW0g1BE0fWjalIVZPuvtw7HlyujM0fce+vJBvCU2nQPQS2hxnIEj2q+wCIgrxtGo=
X-Received: by 2002:a05:6214:f28:b0:6a0:a38e:d52 with SMTP id
 6a1803df08f44-6ab8091c73cmr1975866d6.4.1716330075944; Tue, 21 May 2024
 15:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMB9A8-X+Np_Q+fWLURYL_0t3Y-MdoNabDM-Lzk58-DGA@mail.gmail.com>
 <Zk0HxVODITGKqYCw@x1n> <CABXGCsNbcMn0Z0RudFrBW78rZPE+cDY+f9r+yKf_AZwJZUOrQg@mail.gmail.com>
 <Zk0UA6wABOB9X_Dx@x1n>
In-Reply-To: <Zk0UA6wABOB9X_Dx@x1n>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 22 May 2024 03:21:04 +0500
Message-ID: <CABXGCsOZnxrSHd0y6QrFhzAiY-uTJiRSmo__C_P8Y2qjFV6bRA@mail.gmail.com>
Subject: Re: 6.10/bisected/regression - commit 8430557fc584 cause warning at
 mm/page_table_check.c:198 __page_table_check_ptes_set+0x306
To: Peter Xu <peterx@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>, axelrasmussen@google.com, 
	David Hildenbrand <david@redhat.com>, nadav.amit@gmail.com, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 2:37=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
> Hmm I still cannot reproduce.  Weird.
>
> Would it be possible for you to identify which line in debug_vm_pgtable.c
> triggered that issue?
>
> I think it should be some set_pte_at() but I'm not sure, as there aren't =
a
> lot and all of them look benign so far.  It could be that I missed
> something important.

I hope it's helps:

> sh /usr/src/kernels/(uname -r)/scripts/faddr2line /lib/debug/lib/modules/=
(uname -r)/vmlinux debug_vm_pgtable+0x1c04
debug_vm_pgtable+0x1c04/0x3360:
native_ptep_get_and_clear at arch/x86/include/asm/pgtable_64.h:94
(inlined by) ptep_get_and_clear at arch/x86/include/asm/pgtable.h:1262
(inlined by) ptep_clear at include/linux/pgtable.h:509
(inlined by) pte_clear_tests at mm/debug_vm_pgtable.c:643
(inlined by) debug_vm_pgtable at mm/debug_vm_pgtable.c:1392

> cat -n /usr/src/debug/kernel-6.9-10323-g8f6a15f095a6/linux-6.10.0-0.rc0.2=
0240521git8f6a15f095a6.10.fc41.x86_64/mm/debug_vm_pgtable.c | sed -n '1387,=
1397 p'
  1387 * Page table modifying tests. They need to hold
  1388 * proper page table lock.
  1389 */
  1390
  1391 args.ptep =3D pte_offset_map_lock(args.mm, args.pmdp, args.vaddr, &p=
tl);
  1392 pte_clear_tests(&args);
  1393 pte_advanced_tests(&args);
  1394 if (args.ptep)
  1395 pte_unmap_unlock(args.ptep, ptl);
  1396
  1397 ptl =3D pmd_lock(args.mm, args.pmdp);

--=20
Best Regards,
Mike Gavrilov.

