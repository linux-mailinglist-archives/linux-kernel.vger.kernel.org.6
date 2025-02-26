Return-Path: <linux-kernel+bounces-534553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE8A46869
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC84D188664A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3269622A1EF;
	Wed, 26 Feb 2025 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDKnBqdE"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31266229B37;
	Wed, 26 Feb 2025 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592169; cv=none; b=SrBxEQYvHthcA18x78OO8FjGCb8pDGIxb0h7Qai5ZSe0mInyBcbXTZqoeDb+eyVp9CdS2m5tj46HL+UJ/KloFuC1u+Y00rbPesVsccD7SX8NsxTSALgoI00IM7DdQxeCPJaKnrRNrd4fbUZ0lfy9KYSH5pgWiKa/PqlCBcF3GUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592169; c=relaxed/simple;
	bh=pf1Ym/LYuPGVWFiM/lTbZoBgNa4GshyrvXq8DdYjCZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBGqJbzkwEghFwOISXSu4zUHFEa5FEbsB5X55f+bfBT8Te8Qb5bc/y/YCIKS5K/O/cS01dqiwwmnpMIht8eRTO6erqgN47ywqG0zI/TPObj4eWDAw0BXiZ97AB0cyb8NX7lgA18GJ9PgCSPqSuabqE+o+LeeEPICzy+HPggw2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDKnBqdE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fe9fd5e7f8so27101a91.3;
        Wed, 26 Feb 2025 09:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740592167; x=1741196967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j14nTPHAtaZCMj0Cm4vQzM1gNJxu1aU5P8x9//E1lQ=;
        b=ZDKnBqdExuf+QXInkI2n0Egsogyb1gu0Br23U5jftrldzI/6k9WwzNog8JbetgLT0A
         8NUgeoLKXKFau/XfLJfc0FuqoydgVWbeGjxJ3nntnXB+Uw3n5w+Mt1p8dgGWoPRkF6J/
         PYyGy4+eK3zLTme5Jmurhw9pori5fBA9ggxrS5L78KJFYENcFckH1zIontP5XPCrh8Ht
         BHlj38/j5XYExveKldoxEGYcVWuVsYhM1JQrefSzGCGGcXHLtZm1NjhCbpBSpvUQI93q
         8UjiQaLiEJu/qEDMsllCPEbVB8UwZtLw8ZesijlM7SOQnlbCiTIZf+UJN2zXEwML8cRs
         O8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592167; x=1741196967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j14nTPHAtaZCMj0Cm4vQzM1gNJxu1aU5P8x9//E1lQ=;
        b=B6lh0n0uHy6tKazp1rKbTRNO/oEpAEHDdRLw3dLRAdO/5vgk+hrd4H0JnZDwD5+W1e
         vHGJXMUtP1jonEAymOeFgpqCn37K1DQpAXid8gz71OsFZLfN4sTg5RIiqhKZ+yLEeE2J
         aoxKQju9s0hSPLoCCM7JMQTauhBe/EEk2zvt1d+2vb7rSniXb10MESlBn3KSZ+CV+eNq
         0gvQfW5ZZYu8SqBrRAxJz/FkE0csxaSN4Q5mgutetGRL8kxaD5mtoV63/IrQCWhAXaFV
         pUACcNC1rpF0cb70kyA/2A4dv0EbmtbfU7utbeqRBhGdtcs+69HO2qsTeFmrVNyMjXsj
         dx5g==
X-Forwarded-Encrypted: i=1; AJvYcCWYH0LcXgPfm4w+S0lTZIuK518P+DKyAoFL5SyGDzV40ga7x7z/vNX+LjPcwfrfEhBL0xTkMBIHvRvZPa8=@vger.kernel.org, AJvYcCXi/z585H4or53Ao3CHClN2LXjEqpNUpk0+igpWqTTsBxH5FtOSwJhyl2Im/e3UMpCq7LPhp5V4hcicJhkDvtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoiI5Y37lvYpCAFQnZ7b/52l/jDj12rXGnOuHLEjdqtoc5mlHF
	dXk4p/9055gGFmdAevI2hOL6xMc6AnjyAHCYpWHDsYeht6T4VCV0QgkeVXt0PDpHHfPspLlF3xB
	49DIJW5UgIpU+94Cg+1Mrj2MurM8=
X-Gm-Gg: ASbGnctRr9OqYGoiKL9zPExMZ01S7IuPwxSyG/z2jYYt6F+ytSc+CjDmbhiP4OkVHSQ
	UmiA/tp01QEtLrC6hzLa2oXYc4H/Ms3tcMiALZsRg6/Agn+pEeN4QXO8KPxNx6/Wz8tofWaWS+E
	cAv8X2WJM=
X-Google-Smtp-Source: AGHT+IFW6GDWlGGpqjVzew7MkW1wPR2FwG46MyiXnmowTmnlMztbQM15bxmK//Vd/Upz5e/qpaEJMEC2Of8ep15DZMc=
X-Received: by 2002:a17:90b:38c3:b0:2fb:f9de:9497 with SMTP id
 98e67ed59e1d1-2fce7b0946fmr14733330a91.5.1740592167400; Wed, 26 Feb 2025
 09:49:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
 <CAFJgqgRxfTVxrWja=ZW=mTj1ShPE5s-atAqxzMOq5poajMh=4A@mail.gmail.com>
 <CANiq72mA4Pbx1BeCZdg7Os3FtGkrwx6T8_+=+-=-o9+TOMv+EA@mail.gmail.com> <CAFJgqgSzqGKdeT88fJzrFOex7i-yvVte3NiQDdgXeWEFtnq=9A@mail.gmail.com>
In-Reply-To: <CAFJgqgSzqGKdeT88fJzrFOex7i-yvVte3NiQDdgXeWEFtnq=9A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Feb 2025 18:49:12 +0100
X-Gm-Features: AQ5f1JpctmKLQF0BCjDn8OovkDnRBgv6fuJL4nftVzeYKWrkU3F2aUL59QzVDxY
Message-ID: <CANiq72m8zKABR0dXtkB-UiF-GeP5J4nAGqoabdmR=CfPsJejzg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 4:21=E2=80=AFPM Ventura Jack <venturajack85@gmail.c=
om> wrote:
>
> I am not certain that I understand either you or Alice correctly.
> But Ralf Jung or others will probably help clarify matters.

When you said:

    "In a preprint paper, both stacked borrows and tree burrows
     are as far as I can tell described as having false positives."

I think that you mean to say that the new model allows/rejects
something that unsafe code out there wants/doesn't want to do. That is
fine and expected, although of course it would be great to have a
model that is simple, fits perfectly all the code out there and
optimizes well.

However, that is very different from what you say afterwards:

    "Are you sure that both stacked borrows and tree borrows are
     meant to be full models with no false positives and false negatives,"

Which I read as you thinking that the new model doesn't say whether a
given program has UB or not.

Thus I think you are using the phrase "false positives" to refer to
two different things.

> You are right that I should have written "currently tied", not "tied", an=
d
> I do hope and assume that the work with aliasing will result
> in some sorts of specifications.
>
> The language reference directly referring to LLVM's aliasing rules,
> and that the preprint paper also refers to LLVM, does indicate a tie-in,
> even if that tie-in is incidental and not desired. With more than one
> major compiler, such tie-ins are easier to avoid.

Ralf, who is pretty much the top authority on this as far as I
understand, already clarified this:

    "we absolutely do *not* want Rust to be tied to LLVM's aliasing rules"

The paper mentioning LLVM to explain something does not mean the model
is tied to LLVM.

And the Rust reference, which you quote, is not the Rust specification
-- not yet at least. From its introduction:

    "should not be taken as a specification for the Rust language"

When the Rust specification is finally published, if they still refer
to LLVM (in a normative way), then we could say it is tied, yes.

Cheers,
Miguel

