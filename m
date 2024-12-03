Return-Path: <linux-kernel+bounces-429433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4269E1BFD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4132283168
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DABB1E5000;
	Tue,  3 Dec 2024 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ICjuNhDF"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77861E0DA0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228469; cv=none; b=fN1uZpJWH5XpoSsJjKuUPC4NWDI75ttcAGRzulOrhcIda3R14Cow9Fo7JOttsO/xeTKzBmLoII+FT4kdAFMZyvcBb1PN3OYes6/fKe/9I8oQllNbNzSgcruIFklZ7GJfQaEK+HM1GsoG8iweOmj0rPGDWKZ5j8qbijNBRgpIBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228469; c=relaxed/simple;
	bh=1WImKTFIXOmnid3RYi3wzcqOj3BPOQI6o3xUPdhcFHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mI7qo8UprghFClO8x+I1KqkUIaAgV3lK+9bOB9T65B0zqLTND7n+BK7qs7otZnduLjLodzcD3SruEIAly/9U8IpjXzEsl5cILBcOE5pvAVgCaMqs86jh7OMfXxuGokQMs5oCNXxiuB9NxXDgh6prWw0I1MrTyhtNGptSTxzkvFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ICjuNhDF; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0d71d7f00so4726627a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733228466; x=1733833266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WImKTFIXOmnid3RYi3wzcqOj3BPOQI6o3xUPdhcFHM=;
        b=ICjuNhDFjYor4tRS3Vakn5n3YoTmX2DZonPbqp4VNKYEY39gZm3niP0BU2lcfQqZql
         /cu+xtvauwoCaYHQhkLWVCaxs5ebzddVAz2kibYeJbp6riyX+5sgcPyAGnCMSeSpNMiF
         wu6+FgtR9qEpr5wRhNluf1mo8XTPJDDYupT2CN05+KChmVORoEXMYFtBPEqlnpjJ97mv
         5cf98xAwnW/rq0Ace23lbTTSxuCrMvw+IgCLcrFLUq47atA8JgW7g9xzA25z9X9OVX2D
         wJq6gLL6Av7ZbGq7TSxDhkFkIM8RdT4pMMqiO4GldWXgJYEuyNEEGKwxeKBxYdknqMIv
         Vp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733228466; x=1733833266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WImKTFIXOmnid3RYi3wzcqOj3BPOQI6o3xUPdhcFHM=;
        b=Svj4IMhTTy6SgeHRdf4Tp5C79lUT/pbc/UQK/sBK4uM3gvYNy5hJNSukgfkq7dD5tb
         DVg2CjPm9NSQcqc9iS0EB5/UreYD1733ysj0dHjzvbZAAQagWfn/LM2OrR1S7svn1JIL
         jNpX7X+3ceau/JWiL8gVMl5MAkk4Q3uJAw8cqt7q71XIhQtDirW5oFMjKMVhmIAgBHAC
         8rB4BgL2gGdy+IzA13wkEjVHKsBhOqYKtdYrL20HgXwGEWugEJJAPziuBQ6ahqlK1ysj
         uOxZsLZ3NgiUiHcWMkJHZzyxzEYo7+kp+qsdPOZ6P1hnj5219BjAcgLeZxSaGg4T9fmx
         RPQg==
X-Forwarded-Encrypted: i=1; AJvYcCWR5MVPGzS8NOYHyBS1KEYlJZMWDB2VFO2a6Z+/POTUl1cpvpIUr+JcWQw7vXu2xhvPvNLtz+4pZUGRemk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuNF8DegjzEvbjLZQ39Zjl14e1jTLNjSik5YSSWBs83T1Nu4d8
	1fO3OmpHtHk7Nq7jwnNqu3CxpXfyghkIHWM4SGI8igFb34XkU1Gbrd07brl+bTjJwQqjW234psm
	w5zAN5+d3ZOoHU3QhMsC0BToLhBQKi/UX9K+wrA==
X-Gm-Gg: ASbGncumIGVhIeheQyOO9Nuhl9/3sdwYgInfEBUjXducg0xC/Yg5aSgOGTgmYTeUz2r
	cBVcLRAifER61fHunQjDjol87zbQmvzhV6hhncw6RpZhMglcAVhCc/ZmVaOhY
X-Google-Smtp-Source: AGHT+IECgoPf7qHpNyXgItUjiYOWa+tp6n6p4rrfllPoXDocCVMcuQlttw8uJtNTEg/Pe8c6cPGDTSHhCImfY9HBpRY=
X-Received: by 2002:a17:907:774c:b0:aa5:2bfb:2ec5 with SMTP id
 a640c23a62f3a-aa5f7cc3150mr256183566b.5.1733228466291; Tue, 03 Dec 2024
 04:21:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222828.240530-1-max.kellermann@ionos.com>
 <CAOi1vP8Ni3s+NGoBt=uB0MF+kb5B-Ck3cBbOH=hSEho-Gruffw@mail.gmail.com>
 <c32e7d6237e36527535af19df539acbd5bf39928.camel@kernel.org>
 <CAKPOu+-orms2QBeDy34jArutySe_S3ym-t379xkPmsyCWXH=xw@mail.gmail.com>
 <CA+2bHPZUUO8A-PieY0iWcBH-AGd=ET8uz=9zEEo4nnWH5VkyFA@mail.gmail.com>
 <CAKPOu+8k9ze37v8YKqdHJZdPs8gJfYQ9=nNAuPeWr+eWg=yQ5Q@mail.gmail.com>
 <CA+2bHPZW5ngyrAs8LaYzm__HGewf0De51MvffNZW4h+WX7kfwA@mail.gmail.com>
 <CAO8a2SiRwVUDT8e3fN1jfFOw3Z92dtWafZd8M6MHB57D3d_wvg@mail.gmail.com>
 <CAO8a2SiN+cnsK5LGMV+6jZM=VcO5kmxkTH1mR1bLF6Z5cPxH9A@mail.gmail.com>
 <CAKPOu+8u1Piy9KVvo+ioL93i2MskOvSTn5qqMV14V6SGRuMpOw@mail.gmail.com> <CAO8a2SizOPGE6z0g3qFV4E_+km_fxNx8k--9wiZ4hUG8_XE_6A@mail.gmail.com>
In-Reply-To: <CAO8a2SizOPGE6z0g3qFV4E_+km_fxNx8k--9wiZ4hUG8_XE_6A@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 3 Dec 2024 13:20:55 +0100
Message-ID: <CAKPOu+_-RdM59URnGWp9x+Htzg5xHqUW9djFYi8msvDYwdGxyw@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: give up on paths longer than PATH_MAX
To: Alex Markuze <amarkuze@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Venky Shankar <vshankar@redhat.com>, xiubli@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, dario@cure53.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 3:33=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> =
wrote:
> You and Illia agree on this point. I'll wait for replies and take your
> original patch into the testing branch unless any concerns are raised.

How long will you wait? It's been more than two weeks since I reported
this DoS vulnerability.

