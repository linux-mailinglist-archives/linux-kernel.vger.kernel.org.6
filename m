Return-Path: <linux-kernel+bounces-292909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B75D95765C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183A5283718
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD615A865;
	Mon, 19 Aug 2024 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hnmbyhEO"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D036D158DCA
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724101987; cv=none; b=XS1X78x00m1IeT3v5FZkxRet4k3VoXwqEVLLJUUc/hSDSoDMCbMRjCVyb2Gwc4Nb33FLPs0JHjBbRODs6fekcRBMimVjiT9VD5e4xVw1STCweMeUl2hb4dzQW8YZqflQPSNjhyl/3ISKXn5/NzRdh4C/In4oEmvj4c5pu0pajF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724101987; c=relaxed/simple;
	bh=v2Aym6xEcSutqoJryNuAWCSxUt2U3T2dVmbfnKDCBN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lE81LuwXQukp0+KRtEX5hoE/GARHsAG7oqR1Jx9qM2eBA1nV1dThBsddsAc0TGmPiNExfCdW1E0iN8ZMY+V8gffeNnzUKNZ+VQddfW3iHz3n9PmnHpyaeDB2Ba3DptfzpyhPXv3Jb1niyISBtJ2+eYecJ6HR0ZwSRhIPuS1y44I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hnmbyhEO; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efa16aad9so5958746e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724101984; x=1724706784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5WVBrXjTXXG+AbrwGZturOsFDzAUbfUxMoRB6dkGwEE=;
        b=hnmbyhEOUCRqiWTkya7zEkK+xrDcaerbqcjG67PLLU3bjP/TM5Uc9/60sa/IiCHMoO
         2MQRP2+ripYo72p55xWv6kBdNhSGwZjgxD195qiZX2JwEbZLUEsPrePEX+TtyIDPlFL0
         QKVWKFIo+KlkM4o+CfX0279Uw6XdEuQat/Pqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724101984; x=1724706784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WVBrXjTXXG+AbrwGZturOsFDzAUbfUxMoRB6dkGwEE=;
        b=AMTXWK2OQB0ABZRoQ7gMOpRlKY7+ciWpmuS0GWgOV6S3FokN6mVk4sryTlJ7YzqD8V
         b5gL5LbZcRcgsguujaB7YY0YJPQN0Ez0sixeLwrhBwQJiKEMOHDxDouhk0FbxgFA5KQ+
         nLwLp459rPsqbUEf8NcNUcqYtu95sJ9PlFOZB9NMynRXpFCh/wqSHhN9+nrlHpXXSpn7
         IYhMr891U+z5BgJHePwVxAXqZDPZopnxrT/aULU+1qr5KBe0/URTx4xoFqkA6/I2X2Qg
         vXVA3YLLhSMnrNwwdFc8cuFAtk82fLf6fANZyh6Q1eblrz7Nz1ddiLuNmqWu8ESOztmJ
         OyMw==
X-Forwarded-Encrypted: i=1; AJvYcCVda+omUDeZB2FOp8dx+P5hqVkp2hjsMXfn3Ak87Z9D6qEdt6wFIFmZPAUq5sdk//xVbRVQAs9Tz+6dlr88dBSZh72dfG48llP3y+qP
X-Gm-Message-State: AOJu0YxM8yOLSavEQRHo8XijevRoYlmAdTK7nrja2bBr6iu84d9+2E8J
	7U3brLSg3dPA+zKZPt2L4z/aNmdGDLbWF4IsIRXatmGFXWzALLuGamMYA2axCXun+rktqtbtca8
	yJnjGqQ==
X-Google-Smtp-Source: AGHT+IGkmRPJLSsx9j/5fEfm/RT8WVRZkNM/tbdAU4gaXq39XcMmGOhDxR0nNX+xXb8pceKFo5F2wQ==
X-Received: by 2002:a05:6512:3d8a:b0:52e:9ebe:7325 with SMTP id 2adb3069b0e04-5331c6b44damr8567964e87.31.1724101983314;
        Mon, 19 Aug 2024 14:13:03 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d3b906dsm1576364e87.80.2024.08.19.14.13.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 14:13:02 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso55955931fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:13:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFyQFJ0TEYDx5RaCBVxQmKw4iscOIvT7fDDjBNn4XaqIZ5vf79Orhx8qfK6O4goxbLs74t2Bx+f3pnYlfnCl3kSHVlqd7unaNHLf7d
X-Received: by 2002:a05:651c:114:b0:2f0:1a19:f3f3 with SMTP id
 38308e7fff4ca-2f3be5ddea6mr73422331fa.33.1724101981970; Mon, 19 Aug 2024
 14:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819053605.11706-1-neilb@suse.de> <20240819-bestbezahlt-galaabend-36a83208e172@brauner>
 <172410075061.6062.16885080304623041632@noble.neil.brown.name>
In-Reply-To: <172410075061.6062.16885080304623041632@noble.neil.brown.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 14:12:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4=w4pANpAPbx=Kw-jiExEabJ0pwYHFgAYXVaD0AJjrA@mail.gmail.com>
Message-ID: <CAHk-=wh4=w4pANpAPbx=Kw-jiExEabJ0pwYHFgAYXVaD0AJjrA@mail.gmail.com>
Subject: Re: [PATCH 0/9 RFC] Make wake_up_{bit,var} less fragile
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 13:52, NeilBrown <neilb@suse.de> wrote:
>
> You could fit those in a short and two bools which gives you three
> different addresses to pass to wake_up_var().

You don't actually have to even do that.

The address passed to 'wake_up_var()' doesn't actually have to *match*
anything. It's used purely as a cookie.

So you can literally do something like

   #define inode_state(X,inode) ((X)+(char *)&(inode)->i_state)

and then just use inode_state(0/1/2,inode) for waiting/waking the
different bits (and the numbers 0/1/2 do not have to bear any relation
to the bit numbers, although you may obviously do that).

              Linus

