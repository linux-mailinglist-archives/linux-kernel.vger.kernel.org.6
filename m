Return-Path: <linux-kernel+bounces-577439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D3A71D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C307F16FBEA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715A021506E;
	Wed, 26 Mar 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DLnT6LM9"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E30215065
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009806; cv=none; b=q5K+QYWttb9U2Cm6rGori1fmlIMXhSASQPv/ohW6BhWy03mldAinEZP3FmVI8HY4XwCaFr//5warqhzIrGsqcUPGKEOM4+LcWdTtKjrb4s0Wk3TJULSrG+RTxG2+yTXFMGwDrt8H1GpaVw82HUxr3MUs9iGx99T2s2oJq0VHH0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009806; c=relaxed/simple;
	bh=a2NyMrUiQOV80ARg/+DvduuMj0SZhgXE4j7q8A388ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/ZdPGUFh5Bh5Yi0u6bR8e0HhP6SeaYXr5/uTxOut0gNEinMkCSDzVLn3h54AtfxCE/WvJB6Mb5t8E7VpfmqPjFM6KRdRnMSaZcr/Pq9TXP/OS+cPetJUkvrPAfTe8ubGVLUCeWQwRMlM2BYTRyWPJrMiFK+OnfMt9TXR4dFzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DLnT6LM9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so4162a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743009804; x=1743614604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2NyMrUiQOV80ARg/+DvduuMj0SZhgXE4j7q8A388ds=;
        b=DLnT6LM9SlB6RMADbirhr6CNJF2sQaAioJA4LSFomc9vVEe2phAN4OMEUouTeZAfvo
         ltQ3hH1WCR9uC7Q+HvTNku8cAEpb0f7gDHGspIi25u1DboQ2PX0VpLR7g6vWTtBS29jK
         lEPji/A0X5QVcGlec1f3XoHLBubcx/6wwNZpdjxeEhaMlc3VelQ4ayMkzjinVzSkmlcQ
         uMHugj5FgBdIHggxKkVVaPjrEA5hpIwNAuXXmIPksy9fP1AIy5caVYO4rcrtHo6hzS08
         3g+vXrGPieLruDPg5QUVJFzVDGcxkJm8mxM/vS6PqqWvHM9CInNnLzOKC5J3e986sP/2
         4Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743009804; x=1743614604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2NyMrUiQOV80ARg/+DvduuMj0SZhgXE4j7q8A388ds=;
        b=mhaMM0oQgaYpA9uMq/vsBmauazFBH22K2TjZHxkVvlB900ydHradkVnTIbCuRsDxBn
         fuN0jtV9m3eAXHI0OtQjmdzTFxm/GMQYYUrVPTsVGAj26ftlrfpy1o4aBcrE4cWgTo4B
         /80sCxEyyNBgIRGoJ4uCl+0xnrxBoPbaQw0R/7uIx4jK+BnTcq9ordYX484/1bZrW0LC
         D74cwgDrhN1SjA7kSswmF/k+6tsJkqceCSyYoLYOri9zEHGTcW9z//CwDbZJBR/xSmBT
         DMRkF0C1EvbwLyPEozXABnr/doFESNheQRGwvzBOeXOwsPNDrN2aQrlFtPOahMbtCfDu
         nFVw==
X-Forwarded-Encrypted: i=1; AJvYcCUBuzlV+ZnH/hX/NdZdZpetedIehaW1MCS/Y1oy89PhtUtHCfVz4X2MIVd2Hx8fDj0ftWiJce41dTazUM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrgJeNdE0I5pv0+d/ZAKrlrKD51FjL5zCq0ablcnOLeo6IM15y
	5YCqE2j+TzJeWhSp9HYDDQS5uK9Xdg1YOow6fsjPDmbtH5IGY4N76ZDEJuR9Hl9TdpgnOxtvx2c
	vrgbE7I55oPByI+uLSFoJu9Px+fQaWmqnSpS6dw==
X-Gm-Gg: ASbGncs6MmzueGXIBqoXVsqDr1ZeD70ho3PgC3h6C7bwjPCGUzynHM/epg65/4pzxrA
	KfIjjtsGP/OL0frpFIsLVcKALmM9YGRwvPDdJXJtK2H/2cy+IRYUcAjkdrZcwVk4YI5C2UPbznb
	rXCHHh6A00rp+nhKWuV3D5Alwv
X-Google-Smtp-Source: AGHT+IH7rIFlWyEYfIZ3WN0p7Zb9qCbUlZyp5L8giHJ9QZiKfqAiDrKPrmG0kZcCYX063nmTDXOGpO6drIVHOa7BaQQ=
X-Received: by 2002:a17:90b:1c04:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-303a9185a25mr255538a91.5.1743009804102; Wed, 26 Mar 2025
 10:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325143943.1226467-1-csander@purestorage.com>
 <5b6b20d7-5230-4d30-b457-4d69c1bb51d4@gmail.com> <CADUfDZoo11vZ3Yq-6y4zZNNoyE+YnSSa267hOxQCvH66vM1njQ@mail.gmail.com>
 <9770387a-9726-4905-9166-253ec02507ff@kernel.dk>
In-Reply-To: <9770387a-9726-4905-9166-253ec02507ff@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 26 Mar 2025 10:23:12 -0700
X-Gm-Features: AQ5f1Jq090bRbktCGQj6AKofeV73gODEjcWkjhMdf9jWJZQbbcbRL1wJhVOvgeM
Message-ID: <CADUfDZr0FgW4O3bCtq=Yez2cHz799=Tfud6uA6SHEGT4hdwxiA@mail.gmail.com>
Subject: Re: [PATCH v2] io_uring/net: use REQ_F_IMPORT_BUFFER for send_zc
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 10:05=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 3/26/25 11:01 AM, Caleb Sander Mateos wrote:
> > On Wed, Mar 26, 2025 at 2:59?AM Pavel Begunkov <asml.silence@gmail.com>=
 wrote:
> >>
> >> On 3/25/25 14:39, Caleb Sander Mateos wrote:
> >>> Instead of a bool field in struct io_sr_msg, use REQ_F_IMPORT_BUFFER =
to
> >>> track whether io_send_zc() has already imported the buffer. This flag
> >>> already serves a similar purpose for sendmsg_zc and {read,write}v_fix=
ed.
> >>
> >> It didn't apply cleanly to for-6.15/io_uring-reg-vec, but otherwise
> >> looks good.
> >
> > It looks like Jens dropped my earlier patch "io_uring/net: import
> > send_zc fixed buffer before going async":
> > https://lore.kernel.org/io-uring/20250321184819.3847386-3-csander@pures=
torage.com/T/#u
> > .
> > Not sure why it was dropped. But this change is independent, I can
> > rebase it onto the current for-6.15/io_uring-reg-vec if desired.
>
> Mostly just around the discussion on what we want to guarantee here. I
> do think that patch makes sense, fwiw!

I hope the approach I took for the revised NVMe passthru patch [1] is
an acceptable compromise: the order in which io_uring issues
operations isn't guaranteed, but userspace may opportunistically
submit operations in parallel with a fallback path in case of failure.
Viewed this way, I think it makes sense for the kernel to allow the
operation using the fixed buffer to succeed even if it goes async,
provided that it doesn't impose any burden on the io_uring
implementation. I dropped the "Fixes" tag and added a paragraph to the
commit message clarifying that io_uring doesn't guarantee this
behavior, it's just an optimization.

[1]: https://lore.kernel.org/io-uring/20250324200540.910962-4-csander@pures=
torage.com/T/#u

>
> >> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> >
> > Thanks!
> >
> >>
> >>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> >>> Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
> >>
> >> Note for the future, it's a good practice to put your sob last.
> >
> > Okay. Is the preferred order of tags documented anywhere? I ran
> > scripts/checkpatch.pl, but it didn't have any complaints.
>
> I think that one is minor, as it's not reordering with another SOB. Eg
> mine would go below it anyway. But you definitely should always include
> a list of what changed since v1 when posting v2, and so forth. Otherwise
> you need to find the old patch and compare them to see what changed.
> Just put it below the --- line in the email.

Sorry about that, it slipped my mind. Will try to remember next time!

Thanks,
Caleb

