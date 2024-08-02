Return-Path: <linux-kernel+bounces-273219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1307E9465EB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AED37B22213
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CF613B28D;
	Fri,  2 Aug 2024 22:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoFymbHI"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7110745F2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722638452; cv=none; b=PKP5KeGSS6p3YcOfvUbusxVTenamaVZwEcWpiuPyqFSU0zkqax8I8YqLazZWCYVR+OiVnoaFeLbCmyh9AyzKS2ZKPR+6VfwKRARj3ERP7DQ6O+trQlmS5XwKXh70ef88JvV0dbgXLJY5q2PqRAUiPTzouJDtGRqEogYJvq8Dqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722638452; c=relaxed/simple;
	bh=/AS4PCqiOdbZ+esYBLs/r2lwVfepCVbyBq4ZGB7mHqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYYSVbEd6oKlCWUcuvnoGBgyAaJlKUoIIt8WcbHmLFIA1SDkvJDx3q1FB9SEBmVw9chYYR0U5jbzrnG0WIg+QibwWpECZ/ieVYJ260Rx3tskyF0Vnfc4Dp/2WidvmI7fjjHkocs6FeBmAZNRnN6mbIQ4iT6nlMlXbZWGNGHeBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoFymbHI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367963ea053so5492465f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 15:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722638449; x=1723243249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AS4PCqiOdbZ+esYBLs/r2lwVfepCVbyBq4ZGB7mHqg=;
        b=FoFymbHIiTTpCBf3aKPuT3KzkU6F+6lfTnoKl9PlVV7n5m3MuehPj7EPqwWMhNLZcN
         seZ7j994ZGQIC00QxX9BIjTCliNNNAVnEEDpIgbVgv1v4O4qpvqGgDjTHDkvqB7T74nh
         vgRqXThlHuTd1nRR4KnWeUJcfyzSnoUxMSbDb8Dlqtgnbh4UZZhp3MlDvn+Vtqb2zNq4
         JRIdHqeSCc4+0N9JIyzxmaDnnPwV24ZyCODWDoNzy4yCwx6LFhza6yOM5bm2rCukJ5qK
         QNiqPaQCGS45dBzsIW15tk7mzyTqTF5IlAaVSA3M1eVuHbXSz8DM9m+5C4Ov0OqL/ccG
         nsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722638449; x=1723243249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AS4PCqiOdbZ+esYBLs/r2lwVfepCVbyBq4ZGB7mHqg=;
        b=tmHx09F48ieV0e0iEFEqzZ2YNE5nrokqYq+BnUcRIfl93SJ7Ke+eKDP+I+rXiyGCog
         7+N1e26wX9k+AQO7K845KP1X6gRWa4cnZWMMv4sDVftHZFEKbVURZIQLHtM+HgnepQIr
         6guk1ah1xxI01C563BpyjtmXcW5Mox5rmCm+ujuSz3xPvQNnAx5xoSXIc1QxQzVnwlH6
         9k7gAc0k6n4ZGGyw0nkBKPX59eqlSpBpqtgiWsEgOrCkvtwvPbineo54LyV2jyixy7rg
         lhn5xpWRAdKBOxkIKKgxDXgXV39P/6y8ddVMJVVB+FMankGWM4nUbIXRBpnGqglxnWjA
         ePRg==
X-Forwarded-Encrypted: i=1; AJvYcCWiga76Zdzm9JkKBdSuGZPZMdOdVCe0a29CZD431tItlzwKyM8NnlDXcn40Yhmq6bAZ4x5xkC5duhyFPdhlsVzE48dMJW6xAeIH+THY
X-Gm-Message-State: AOJu0YzQYquTO1PBBvPIbOHN4AIQVUb9vL4PYNLbZcuLwOsTHlPwkr4P
	N1oqgGC+nkAeEPW0zCvhabtDFjdSilBH0neSuZt64QWRmi27PtoDZHO5c5hU8LTgN5X5YoPxJzE
	J8cCJ1Hj6sFp4BAuLl9cml7RcQFQ=
X-Google-Smtp-Source: AGHT+IF8449QxY3t8SkkFK2YfVgF3YWp9glPxk3SBTBF2/RQWo9PnCHlyQLOyQPaq8g0ThC2WlvdwDsfuUmWphADdr0=
X-Received: by 2002:adf:fb85:0:b0:367:9903:a91 with SMTP id
 ffacd0b85a97d-36bbc0e0cdemr4158321f8f.11.1722638448698; Fri, 02 Aug 2024
 15:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-kasan-tsbrcu-v6-0-60d86ea78416@google.com>
 <20240802-kasan-tsbrcu-v6-2-60d86ea78416@google.com> <CA+fCnZeaphqQvZTdmJ2EFDXx2V26Fut_R1Lt2DmPC0osDL0wyA@mail.gmail.com>
 <CAG48ez0ggtaV8MF-bzzS2=zKg-3nfG1G_QaqGdesAJpQSj39TQ@mail.gmail.com>
In-Reply-To: <CAG48ez0ggtaV8MF-bzzS2=zKg-3nfG1G_QaqGdesAJpQSj39TQ@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 3 Aug 2024 00:40:37 +0200
Message-ID: <CA+fCnZcZbP-PNG9BZfoOr9UEoqxqLkCviS8ooWOLc4Vp9+XimA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
To: Jann Horn <jannh@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzbot+263726e59eab6b442723@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 11:35=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> > Ah, notice another thing: this test might fail of someone enables
> > CONFIG_SLUB_RCU_DEBUG with HW_TAGS, right? I think we need another
> > check here.
>
> Why? I realize that HW_TAGS can't detect UAF in a TYPESAFE_BY_RCU slab
> after an object has been reused, but here we do no other allocations,
> so the object should still be free. And the kmalloc_uaf test also
> doesn't check for HW_TAGS.

Ah, right, all should be good, I got myself confused, sorry.

