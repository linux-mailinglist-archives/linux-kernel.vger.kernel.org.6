Return-Path: <linux-kernel+bounces-276787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CECC949864
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1186282F69
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BE0145A10;
	Tue,  6 Aug 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyTfmA3d"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F96823CE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972907; cv=none; b=iSBLvb7CxoussPkT4OX3oaiovbVkIFzoaWsFJxnCAWwVxcVDTTTHdgpBvMlK/JNXVQg9u/fZPQ+PPNGAmn8xJFAgAHTORFsPRabnMyiaCD+UNw30cA7sKFRPD7qDORLNwPFZyNHEHSnbNcEcxgMtyNQn59at/lpQDvvI1rZ+fsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972907; c=relaxed/simple;
	bh=V/T03AM219iZ6HHZcbsYExrncgiedcnXl3ocqsywHbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMuzg/7CUazSearXvINlAjiaZoEyGrWBZuFtmLDbN3W3P62jvTyqnoV/wp75cCfALIm5jDNCxj4dJeROA2+dQwbysuVZ++tLcSDMY0GdkVQphLZgHVmQMW48ntGp3setpCLgGZ03uYQrRDz4/ZwLhVRH4LmfUtQLofX/nPTb38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UyTfmA3d; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so1599602a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722972904; x=1723577704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sN15+GrqjqV+KY/9xz1S8u6+7LyFlTeZFis8FIS9u8o=;
        b=UyTfmA3dUfznTbVN4I8fuiGrTM840W55JrfK6xGIJOwZ0+czMJt7qLQTdyA47/GsSn
         DEfRoQ4gYwp23J3RxcofhUOjaHMPR74kMk5JFJFBvEQX7JVAo4RJNRBbn4WyT+GJ3Tni
         QfcreyR4uI1d9AZvrcE2FWbzfJOr4OT4fzykUWCbbqpH+3xVAetnrn2L9lEYwGq/9JIl
         b1Kr9SpXuFB5qTXso9hGlv7kameNaLyOcXBCGCQVjdC1yWddKnYqtHWW311Z+jPRu3QJ
         I3JYsuYYuBJ/i82VdMfygdWEOOpupIrdJyVvny7J+zwtZoR1qlYvx9bo42Cl3srRgcy7
         4Vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722972904; x=1723577704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sN15+GrqjqV+KY/9xz1S8u6+7LyFlTeZFis8FIS9u8o=;
        b=CKbHluMCvDqudMJ9WteLHCyBcBEQDRiQixucUyvleb/d2ykSYSnoQlJk5L3KwV3Ia1
         G8BAU+tnxuWbGRrYEaanmI/Crl5nZVsLVwd75z5udQbx9JIHVVGHtnN3haQu+0HTfFBT
         gaolYV0OzjSB8lufbUrPJtpea6p6tRL9Ibve3QdoMjpUXPcz1gX0UJv7tfxqkUBWTmXm
         H5coZBnB3XaIdvaXDP2k7q2RaM0UA2/W1sHybPg7D6p/Jy+EDL8LSkhWXM0SUsOGLNHd
         lOYU8w1C4iq2zCwVng59lMMcdnrT1bR2tie9nHNXFReuPfF11tV5dPBHdwnyglxAkK5y
         WWEg==
X-Forwarded-Encrypted: i=1; AJvYcCX2if/LUr67RDzyMiFzEznEsiVmNJXjuUptaT7DyQKMm3gRZPIyfXHO1QQ0F0G46HAC59SMaVr4LjZG5gdKOOOZMpBzKqwv5x9R36f7
X-Gm-Message-State: AOJu0YysSC2ag6D8zOygNVqm7LJjtkfSildUmbHCJpMKf0essQVgMgOL
	9E9KhISVtPPr7s0iTz50XCoyBYfYMsPWDtTui+2CGIpPWFyC6uheYQ/ch3J5QJoOQWCY6DcBor5
	VWhwT9NVsg8DhzTk/uAKdgNmzCItCpF0JZRuZh9O9WkGvGtczCHv8
X-Google-Smtp-Source: AGHT+IHpyp/NcqymB1GpTBG45STzdu79GH+M+6dKGYHaOQJOfA4Nag5FMNkDx/i/JVFgiaUJ7hbh/cLTks64jO5PhjE=
X-Received: by 2002:a17:907:6d25:b0:a77:e7b9:fda0 with SMTP id
 a640c23a62f3a-a7dc4db2a36mr1003506566b.14.1722972902954; Tue, 06 Aug 2024
 12:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806022143.3924396-1-alexs@kernel.org> <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
In-Reply-To: <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 6 Aug 2024 12:34:25 -0700
Message-ID: <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
To: Andrew Morton <akpm@linux-foundation.org>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	minchan@kernel.org, willy@infradead.org, senozhatsky@chromium.org, 
	david@redhat.com, 42.hyeyoo@gmail.com, nphamcs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 12:32=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue,  6 Aug 2024 10:22:47 +0800 alexs@kernel.org wrote:
>
> > According to Metthew's plan, the page descriptor will be replace by a 8
> > bytes mem_desc on destination purpose.
> > https://lore.kernel.org/lkml/YvV1KTyzZ+Jrtj9x@casper.infradead.org/
> >
> > Here is a implement on zsmalloc to replace page descriptor by 'zpdesc',
> > which is still overlay on struct page now. but it's a step move forward
> > above destination.
>
> So the sole reason for this work is as a part of the mem_desc
> conversion.  I'd like to hear from others who are to be involved in
> that conversion, please - it this patchset something we should be
> merging?
>

Matthew asked an important question here that needs to be answered by
zsmalloc experts:
https://lore.kernel.org/lkml/Zq0zucMFsOwATsAC@casper.infradead.org/

