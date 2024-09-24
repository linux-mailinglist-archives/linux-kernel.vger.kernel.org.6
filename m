Return-Path: <linux-kernel+bounces-337210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A079846FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33ECA1C2283E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BC31EEF9;
	Tue, 24 Sep 2024 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtQObYR/"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0E1EB31
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185594; cv=none; b=NK14DGLLF45X4qoLz2Ajmy3+cN2xlE8GNEM5PoedHs5Z6Cz5H+faWBR941mRb8Kua9CXiuPlW1g2wcpk+OkDmwjFdNwDWlCBBTyyS9NoPCIXnYCVqqf0mL9d1HxjwB5PDro8FQQUaH24fnn/Oj1P4ruBfgNlaOeBdw1h5wbgszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185594; c=relaxed/simple;
	bh=QVtL+3KVFqPq/oSf1Yw5Zipj+SQqfOMkPscBopyOfok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6J6TrwKOklseap0jVLw7UB96sgs9Z9p9OwF767Omet3XBewMwGnILwRQY/YDMbJk2k52l5P7D+DsnkcvCvJ+X5Za+bG/2VMT4Kfv+UYVyjZUdshOYbVLLAzlDmxunM8y1WKaI6H6UpBSJyaI6ZwPYRvxGYENCzFy1M65eqgKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YtQObYR/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d446adf6eso857641766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727185591; x=1727790391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS+n6lf0ewZ4C9NqB0m2FPDZKb3ZOgpjWOZUUqgRpHA=;
        b=YtQObYR/4/b4SR3neujDuSjFfzdbwQxGrUsJVtoLZ9HnF78i3ZK+Q902irt+yR5Qko
         3470zp1g5tURfNsgX/hH/hdDH2+SaN227/ahqtxrmOIuNq6A84Tk1CGGlrrG/WFrINOX
         nndXaui8hpn7ffw8t964lbOrerjBW02jqUTzFD+BMqJQncynuP8FYzhIiFJreC+viLHJ
         74GA1nmOYxMQJuLrsqZiUAhfHTAOSxCefukrMw4HABTKceNEIWODyn1qZ8JM7IRnCjhX
         ifo/sX8C8gDyCkg+E8OMtkO+VYtcX8CybyKA/ph8oOi6MAJDVXo2Stn/klpKBlDkS4jk
         nITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727185591; x=1727790391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS+n6lf0ewZ4C9NqB0m2FPDZKb3ZOgpjWOZUUqgRpHA=;
        b=orc6MyUQ4b/NXcu5YJoizARRJGrsyLHJWG5wbpHRJX9W6eypCzyKIATgnoVsX/VAUq
         r9Di3i/fozRHZVN2Ni5pQyrYuaRNFL+T+Z70BjyO1iGeCVw8b9mfXhUKtWh3wzFE9Nmb
         TtJR4OR39QUMRQLLXh8plgzh6aAkRyXIiHu/DG9d+LC27euGOrco1Kh9oRSwZyL9Qiyj
         DU01tsV5LQkiUoSeXaHNIgAFVEasv4+gvOKRGXqAvV6N7Z4LHgosFZfRdrSdX2S3SJlD
         7YvZNuTZzJtym4krlocbMU9DVCcUvySOwt4rXcFc9BubZJ5huHyhm9BhYlKydXBOD7Ve
         NhXA==
X-Forwarded-Encrypted: i=1; AJvYcCUX0nttO4axxSJdwrHK2L/sVuOsEFQ2d7AmRwfsa8HeGhpLAiN8RZwuuHEjKCdm1VB/cXu9M8HUFG8EF5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDuGM2q/Vfv+bWG60BIo/sQByoJ1H+e4quIhS08iQJBSlBtL5t
	H77hgl4XUBJ6JJ796UruRhenbe3wOVo9NdRkKVGEcrlgXGZTOoCM2/ZG9I1glEUrtCjALFodh8n
	aQF79XMdhdwoY4ppOIllDLr+YH2V2EuYScT7w
X-Google-Smtp-Source: AGHT+IFfDvU0QoxZl9U8yx2iVrPx9Ckr9pP18sGwnClBif5QuPOwDAhR+U/DPatMes1QIHSjN3FU6qPJ59E6u4F8PNU=
X-Received: by 2002:a17:906:dc8d:b0:a86:ac05:2112 with SMTP id
 a640c23a62f3a-a90d50e1eeemr1406536066b.51.1727185590419; Tue, 24 Sep 2024
 06:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14BD7E92B23BF276+20240924090906.157995-1-yushengjin@uniontech.com>
 <20240924063258.1edfb590@fedora>
In-Reply-To: <20240924063258.1edfb590@fedora>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Sep 2024 15:46:17 +0200
Message-ID: <CANn89iLoBYjMmot=6e_WJrtEhcAzWikU2eV0eQExHPj7+ObGKA@mail.gmail.com>
Subject: Re: [PATCH v3] net/bridge: Optimizing read-write locks in ebtables.c
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: yushengjin <yushengjin@uniontech.com>, pablo@netfilter.org, kadlec@netfilter.org, 
	roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 3:33=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Tue, 24 Sep 2024 17:09:06 +0800
> yushengjin <yushengjin@uniontech.com> wrote:
>
> > When conducting WRK testing, the CPU usage rate of the testing machine =
was
> > 100%. forwarding through a bridge, if the network load is too high, it =
may
> > cause abnormal load on the ebt_do_table of the kernel ebtable module, l=
eading
> > to excessive soft interrupts and sometimes even directly causing CPU so=
ft
> > deadlocks.
> >
> > After analysis, it was found that the code of ebtables had not been opt=
imized
> > for a long time, and the read-write locks inside still existed. However=
, other
> > arp/ip/ip6 tables had already been optimized a lot, and performance bot=
tlenecks
> > in read-write locks had been discovered a long time ago.
> >
> > Ref link: https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehalam/
> >
> > So I referred to arp/ip/ip6 modification methods to optimize the read-w=
rite
> > lock in ebtables.c.
>
> What about doing RCU instead, faster and safer.

Safer ? How so ?

Stephen, we have used this stuff already in other netfilter components
since 2011

No performance issue at all.

Honestly, this old link (
https://lore.kernel.org/lkml/20090428092411.5331c4a1@nehalam/ ) is
quite confusing,
please yushengjin do not include it next time, or we will get outdated feed=
back.

Instead, point to the real useful commit :

commit 7f5c6d4f665bb57a19a34ce1fb16cc708c04f219
    netfilter: get rid of atomic ops in fast path

This is the useful commit, because this ebtable patch simply adopts
the solution already used in iptables.

And please compile your patch, and boot it, test it before sending it again=
.

