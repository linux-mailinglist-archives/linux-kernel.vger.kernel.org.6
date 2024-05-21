Return-Path: <linux-kernel+bounces-184920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B3B8CADCA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0771C22009
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EA374BF0;
	Tue, 21 May 2024 11:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UylNg7kn"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4F487BC
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292753; cv=none; b=aVnGBLHbaG4UlPVGcD3djCHQGrBtXpdoMUffkBF8e29ojIlm0HhRftRwpcWRB0mKkUNv1hfw3CvZdgZjXokSoXbFajQWQW3qxlu5qd+3mKMcszaUVwcexz/3XV+3gKLlyfCZTJ0KTI47Eg4S7dIvmmSUceK1mJg2y1Iu/1XLAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292753; c=relaxed/simple;
	bh=K3vsd3uhy9YdufbIZawXIs0ywiHywtbpJojvkj73LZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKe6U01xq6vhC8Qq6iUQPwsBLL2KzLY8y1zXDk1sWxOQRSusP+I3K24BwsXx9Hvn3T2hlaohS53B9DE59ZOsTtmJHJFhDw64eeL25HeQYk9nEB1W5uDxCWLfXQKFmVZCnIyoL8LnxjIVt17zzFg+iy7JNqhFYX14d5KbUWV/isU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UylNg7kn; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e564cad1f6so75120351fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716292750; x=1716897550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaF7dhJrVHfu0NhAhEpiQlXPpI6za74xLYPKziNJgIM=;
        b=UylNg7knc1nICcFAhK6lXSdOloCxL2lRh/mRlccPVmBRxR5ocWjan/R3NM4bhBbOx1
         gz6SP6+KYeO+Ji61bJu9/klnkpBNUEXBDxSdvwG+hJ/xBsDhuR7R96hkE9LOTXuo+0Eb
         UuiRTPBPjqyU4p4B6XFGCQJpTY+7GhX8vqVVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716292750; x=1716897550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaF7dhJrVHfu0NhAhEpiQlXPpI6za74xLYPKziNJgIM=;
        b=R1LmbiIv9TrWMDauO4SyeGDnmYsMgh8YawER997MqUDSxvEE3a1qFTu6l2uWRzXf+m
         2IPD5MIRdmusGduF+BPjaRNMBm9YGyWQdSBZmh4ddD+h+/tFAKSSOiCUy6UYg5Zx/hHh
         y43TU2j6Eiz93CuE53d8N1ZkkM75vaS3QqKUKjJtYBDXpjh82ETOt7OfuQA+0rcSEALs
         sOEWJ6RiQqQQr9S7VdpU8TCOxpPKZjD0u3VXx52FdmyrQ0wt3+m87JvoxNEaHGMJqV+G
         g1/ZZbosMko2oZ/mfUiuTjnDR9rfkt2rdBvks5PiuzX11dftbCZoBw1pd5ZLneKRCd8N
         ULbA==
X-Forwarded-Encrypted: i=1; AJvYcCX+3/0Bph9/2VeSIZs9tfj1yMQ6wwJ+f4rJnDkZsYaccnaHtbMLbRru3BIINhocnJHtGgDYxvB+I6XjZ9IFEcC/x3yELGmUMitXtLrB
X-Gm-Message-State: AOJu0YyhDHpzQUP7IlcyRa0JC2Phq5CN4WRnWq2kfk1yZeabg7psjpLD
	DGpHEHNs/TYv8G/e38ujpdO61vZbGmvOkApnH5OuhPovZDTvlKQIV/C+3VQLFApYu2c3hj9RsHG
	cNnDbOfje2x3cS2n5QUVMlrSSvTVvCE/NfwA=
X-Google-Smtp-Source: AGHT+IEf0u/NpJo9wTjIoclF0Ri0fKECi6HQGuymG+8zN2rXXOQGQw1Ttl/rxAPkE9lxE8kJyWhfdNIH7/Isza2w5bs=
X-Received: by 2002:a2e:934b:0:b0:2df:d071:76ed with SMTP id
 38308e7fff4ca-2e51fd4ae06mr198771371fa.10.1716292749979; Tue, 21 May 2024
 04:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-28-jim.cromie@gmail.com>
In-Reply-To: <20240516174357.26755-28-jim.cromie@gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Tue, 21 May 2024 13:58:59 +0200
Message-ID: <CALwA+NYbp7Niky6r3HBhpxSeJdJMwJU=Vk-87L5vVKqd4RSfSQ@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 27/33] dyndbg-doc: explain flags parse 1st
To: Jim Cromie <jim.cromie@gmail.com>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 7:45=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com> w=
rote:
>
> When writing queries to >control, flags are parsed 1st, since they are
> the only required field.  So if the flags draw an error, then keyword
> errors aren't reported.  This can be mildly confusing/annoying, so
> explain it instead.
>
> This note could be moved up to just after the grammar id's the flags,
> and before the match-spec is detailed.  Opinions ?
>

IMHO the localization of the note is ok.


> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  Documentation/admin-guide/dynamic-debug-howto.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Document=
ation/admin-guide/dynamic-debug-howto.rst
> index 7b570f29ae98..ccf3704f2143 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -106,6 +106,16 @@ The match-spec's select *prdbgs* from the catalog, u=
pon which to apply
>  the flags-spec, all constraints are ANDed together.  An absent keyword
>  is the same as keyword "*".
>
> +Note: because the match-spec can be empty, the flags are checked 1st,
> +then the pairs of keyword values.  Flag errs will hide keyword errs:
> +
> +  bash-5.2# ddcmd mod bar +foo
> +  dyndbg: read 13 bytes from userspace
> +  dyndbg: query 0: "mod bar +foo" mod:*
> +  dyndbg: unknown flag 'o'
> +  dyndbg: flags parse failed
> +  dyndbg: processed 1 queries, with 0 matches, 1 errs
> +
>  A match specification is a keyword, which selects the attribute of
>  the callsite to be compared, and a value to compare against.  Possible
>  keywords are:::
> --
> 2.45.0
>

