Return-Path: <linux-kernel+bounces-529542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA608A427AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FC63B8FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC888262818;
	Mon, 24 Feb 2025 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="lnahq4jv"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AEA25A2D9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413766; cv=none; b=irhikk/3fen92PnBcHTqeMwNx7fPSKgLcopI1PhecBBmrA1IRdLoudirtx6Y5ubLaG8DW8YY2trvjzOeD4cXGMFAOXAoHF5Eo8xF4ZnpAX8wKALk8yWCW/jly/p3DjdbNrQXdxcz05kMzKCGCzupSz6Rdvc5SrhoaRF5Y3JsQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413766; c=relaxed/simple;
	bh=znP639qDra56/4CUkzxbXJtwHv7Db21X2va2+tu0sYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gt0DFul5aTicE3Oq8a1gXHMg6soPKc06PfUlJjFWGgyrVF9hTAFDQ4Y63PqPLvBylnJ7C0JvXcKiT6afT+LtOB7TV3rg4Z4ucyx1TZy7UKmEVR0UmKzpsRMaXWoDYuyP19M/9blYSEFl41bkIaDKjZIsUJB4MJDTv+vXnL6sc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=lnahq4jv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220bff984a0so97384885ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1740413764; x=1741018564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbFIiyVBu03rSNrD6SoQF/QaduESan/tbVEXpCDAIFo=;
        b=lnahq4jvtuhPxtHg0lUUhB7W4b5zdBMChBao31Gl7voRCMDBISD0SI5MY/EXw9/wGz
         4ufHSu+DiQtNAAobMlQHgEhACdgMCIAYn+ZuDROPFREvJtQm+3qC+MiLLBTSt+VZXVQb
         ey9fJA5oPNnx9UUeh/HuSxvtiSGt8iN9i3NSPcn/Yyy+h3FOmuwfF40vTLR5dwP61QFu
         NgOspP9pXU4yk6hjuCy28pyf2cF3QZ6GHR+IXNf7G4PBYXA88CMGhW6nEQVcxDSHTWUK
         4wpm9CnOm+svkLvzP9AEOrTUAsEi4xVYY+fpbEfsWVRO6BPjsCkRmlsidujNUTD6CUYH
         mVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740413764; x=1741018564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbFIiyVBu03rSNrD6SoQF/QaduESan/tbVEXpCDAIFo=;
        b=d3J0KO+spcZBDcZE2oNr/WIn9do01Jl3SnjbvM703mCBQqGvvaaNKSj3Ybt3bOCidS
         5bcmkcJiwMuUKOXsiHnoGel3NwTGoCBOe4Q2LvYaRreU0ggmujGAP7ky4/wzPZ8UuYLF
         ijECU1TyDptptNfcVXhHDDU7sddNQcvdOMxD/ww6eb/eFG9O3X5tU+pRYXX7p1Z60fAU
         ch0QgoNPPLS3alhMCf4yl5KOdvYWF9AHkSSkJFQrF8QZ7ewE/pKsLLr7DYvj05JB9aCv
         r39kTT0mTKorq6/f2jBo4vr0Fk+eL8aEAjAXDKPm3iiim0hsOvz6+K3/KghnXLB3AoFC
         yJNg==
X-Forwarded-Encrypted: i=1; AJvYcCX41Lr+Oz/1/QQ9AiL//zuXCHtoINxytZ+wc3RaJ05RmILaCUMy0JSNvStINpu4QPb3jOT0VHJXBR1ZBY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu2sRckioFpZjY+Pc3fbyfow4hc0eqXV+2Wtdz2ql9d8RPtr/D
	gjFqywqOkYj01jnya9x55Myu+/4uSUZrVgrluo0VEShupIHx9UxyttqHzQ3mhpNW0k/RzhddeRS
	rA1L0TUL8qUITMYdNGFTKZhidxmaeVeCnfucsapGpmpkjkABeBQDWZrpjyQuyvUp/NIHd4244Jr
	iCtGU0WHA/M2B0kNkVNah57hgljqRt1LANYsM44Q9rBGtIM/QfwcAzltBnLZFUsES9wWRKyZhmP
	5JAhHNP4fm9TpzxXS+KKU+r7Kfp9e9QIgB/bCa6VaV+VGvChSXe+rwl6GjPGdp1ndTjQkgHk3x+
	hHp/4DAXj5ha+aQzCIgD7NzLTwNevKd1y+kg4v+V3/w7Mkp1v0youWcJsKHqInlxGO5DVQByRtn
	wCHjSjwwQJYTKB9+XPlUT
X-Gm-Gg: ASbGncv+gKe/NYBt3b5LZa87umCm2zBFUPlbaEqCBEdb3GBKDQpWWXMUiIK7kxnphzm
	9VgzdocSCvUH5g0mY4ZQf9K4npFLx98Kx/m4CJqEDU/G0+xRy6C8fj9Ng3pknKuqmx5O1nCsWIk
	MgIOzsVY7T6C1k3MBHOIAynA==
X-Google-Smtp-Source: AGHT+IEQcUqXWyzW7txhoFxLDejkrVizVTPPzSveJ2vrUrEWjOUz5Sv5py/r8tfjXiTPcGqGgkDF7WJoXP7Am8Q34zY=
X-Received: by 2002:a17:902:e74b:b0:220:efc8:60b1 with SMTP id
 d9443c01a7336-2219ffb68c7mr179690365ad.39.1740413763937; Mon, 24 Feb 2025
 08:16:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081328.18090-1-raphaelsc@scylladb.com>
 <20250224141744.GA1088@lst.de> <Z7yRSe-nkfMz4TS2@casper.infradead.org> <20250224160209.GA4701@lst.de>
In-Reply-To: <20250224160209.GA4701@lst.de>
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Date: Mon, 24 Feb 2025 13:15:46 -0300
X-Gm-Features: AWEUYZlaokoekDAILx5r9gFW_X8gGLcj_ZVwIHgsDoW_nk-h_xzSP63aCt62qg4
Message-ID: <CAKhLTr0bG6Xxvvjai0UQTfEnR53sU2EMWQKsC033QAfbW1OugQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio() with FGP_NOWAIT
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	djwong@kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

On Mon, Feb 24, 2025 at 1:02=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Feb 24, 2025 at 03:33:29PM +0000, Matthew Wilcox wrote:
> > I don't think it needs a comment at all, but the memory allocation
> > might be for something other than folios, so your suggested comment
> > is misleading.
>
> Then s/folio/memory/

The context of the comment is error handling. ENOMEM can come from
either folio allocation / addition (there's an allocation for xarray
node). So is it really wrong to say folios given the context of the
comment? It's not supposed to be a generic comment, but rather one
that applies to its context.

Maybe this change:
-                         * When NOWAIT I/O fails to allocate folios this c=
ould
+                         * When NOWAIT I/O fails to allocate memory for fo=
lio

Or perhaps just what hch suggested.

