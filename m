Return-Path: <linux-kernel+bounces-277093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EB4949C4C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496591C20C0C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF17176224;
	Tue,  6 Aug 2024 23:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jptomQYz"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08378158DC0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 23:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722986865; cv=none; b=GfGQjdB8EY+LqsP8WQomOHNh+b35wv6OFx3joVOriDMgB1q4dhEKKu/psOTH43ZDxe98a6xszMaocKjZEphMgOh4/58wYG88BVwfy+wbPMZSV82rGAL3Tz6fQlfoiP/ydyCNBCXLmCyWQvmQo4Ji9OJd0YxTWF7BVSFs39SCwW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722986865; c=relaxed/simple;
	bh=U4XBKmNd/sc5iaWg5YY1sJfrDuwcDn8kYz8CU/GS5GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkNKyvnYbLpybAA39xWeqiIaJFtNO9/JyIa+Kwan+y0c/jFBTH4CMDoweR0GJsv3WVe6qdV0GAAofw9BVl05WjxM4Lbw3gbqsVZrWJTEquxZru5RxeG0e3czFMzVXYL9I6mEkk62OXr1Sq97ZzD4EA7jHXgjDiepLghqOWNF5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jptomQYz; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4f51c1f9372so385725e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 16:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722986863; x=1723591663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImuNIW9+NhiAFgSF9gmDv1et0ZqWjtHmw8iHiQSAmCA=;
        b=jptomQYz3sQo/x44uIs1vYVViihfrbxcslW3z9bPKjwSLjKMBmZ+519uWlRXygm+m0
         P4UfJFFMnd8wtjEBjI+1jg8fVK80uHdBJHWeatf0tWSOmvujYPIebJNnP7fktCsxeZlB
         4UO/lubeaN7WSQ8lD21G761e8Kvig4jj2LhWmGvdgNPLJz2oHhiR+MuAcMoTScncIxek
         l4XakD5n9/xPFoeTdmqIEz3iD4NnxA1tE28utISgBgGKCbnaDN75B42/4W/wj8tsICTP
         b1AvMqAcNy7Zwc+944/vP+cdvA9ToCocAnNgBw8bsvTA0bMs2zL1M3a0sDuqQKaMye24
         CNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722986863; x=1723591663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImuNIW9+NhiAFgSF9gmDv1et0ZqWjtHmw8iHiQSAmCA=;
        b=HqUGhsvoFfHY4WU8TDoaTL1ghik2/ISIijg8bDpbMa+hYwzGe72cOhK/vu8nNHxxfP
         zQc4dREcpxrscQVI4Knky7BO1F5ad70EcIVREyqzAZH3tuSwx4WoT8kCQ/RX5xGDALsH
         nvqDUpYpDSmXHF0pfvJdfpMeW6YcPVauYpkIpJiIbGtEhrsHwvj8frZOxLlifdC5u1h6
         O1oYOE2mDq1Ivbps4TPk/bofrlxKWVf37fChFBQMpmShUzjT6eDAb/mQp5vFaazKm6aY
         D/9wDUhE6FdFCPtv2Xv0qafEKaPaMDB21kp5hZ7UC4JnkL0X1KAaa50ZtixeAAuzS+Sd
         G+tA==
X-Forwarded-Encrypted: i=1; AJvYcCWfULhhI5n8y3pj+Rkj0ZBirk83/iKe5UMv0tp+V2lNeF5cNW3MZ0yg45Ys61aVjim4JQbgifWvqMTc3jTNHJLP8lO1dyUvfjq/8KBs
X-Gm-Message-State: AOJu0YyXVH8GDTU/u/mGHx0tT9hWV0k6EA0ZY1D8vDN5OgpkA5tdWJiw
	GS0UMN1AE9PghW0T3viY+oft/BZwJbvdxm7orNGArzu4Iqhh40qWNvbfBjy2PjWOGpQiZWLyiDv
	P21AvQkoLTyMabGpI5TJOPkLYDxw=
X-Google-Smtp-Source: AGHT+IHUW+bKaZdG4XIQvpshzrRrIOQnrO1tRl0RD2CrHe3evgDnO7NvFU7+nMDugCcM/61NxnE+g+W7T2arFZvrzd0=
X-Received: by 2002:a05:6122:1d13:b0:4ed:12b:ec99 with SMTP id
 71dfb90a1353d-4f89ff3a3b1mr20885349e0c.3.1722986862813; Tue, 06 Aug 2024
 16:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806012409.61962-1-21cnbao@gmail.com> <1e6bcaf2-7c48-4be0-b101-ec2ddc4098ce@redhat.com>
 <CAGsJ_4xR949nPauJ4kZpcg3cRwvcrHHWU7oSazpfGR2Tv5XNTA@mail.gmail.com> <20240806154112.5d6e63b527c3a9501ef5a851@linux-foundation.org>
In-Reply-To: <20240806154112.5d6e63b527c3a9501ef5a851@linux-foundation.org>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 Aug 2024 06:23:31 +0800
Message-ID: <CAGsJ_4wjFS9Yr=vb3kPWpfCrxn58AE7VifrwcvAYvMPfsC_KEg@mail.gmail.com>
Subject: Re: [PATCH] mm: attempt to batch free swap entries for zap_pte_range()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 6:41=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 7 Aug 2024 04:44:44 +0800 Barry Song <21cnbao@gmail.com> wrote:
>
> > > > +static bool try_batch_swap_entries_free(struct swap_info_struct *p=
,
> > >
> > > Why call it "p" here and not "si" like in the other code you are touc=
hing?
> >
> > that is because I found other _free_ functions are all using "p":
>
> `p' sucks.  "pointer to something".  It's just lazy.  In this context, "s=
i"
> has meaning; lots of it.

Agreed. I'll also clean up the existing "p" in those _free_ functions
while sending
v2.

Thanks
Barry

