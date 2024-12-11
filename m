Return-Path: <linux-kernel+bounces-442028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524B19ED719
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BD62835EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBCC1DE3B3;
	Wed, 11 Dec 2024 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KxnPqO9N"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE272594BF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948328; cv=none; b=nB1DDVSJGqj26rNJSSqMYp3/5ajrMoyN+ZdHw3wemRFcb8Quw9pHsUcRHvaU4WOOgX2wLmefhnIUPXnmuPpXMyx+1MxTUEbVGpujIlhxeEjZvAFlQknvPHaMfeqSLeG3kMfDl6YEa5fuvQVF421KJEXKHmMFqIgf3NMQlZ1EEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948328; c=relaxed/simple;
	bh=7tx11voFFVP3IYFqISOd2sFb+neQ7+49Mm9v28YLhNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njV1VgkJkNcRo7f1Rr9XIWbE6X7g1v2MeP4tcpCJwTUMxl6QMob0XwWGSVSb6UV5NL0QLkvn/Ck5TgtQFNtBn8wcxq8pndVpFDTOXHugiNnLfDdfr18QCS5xBCi70qtrF/68H0LmUpr41sjPNv5N1sqVr/P8CAYDJ+rAwoMmx6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KxnPqO9N; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so9626706a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733948324; x=1734553124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vV39xl6te2UHUQhPJCQM9MYLL2zU7bfjgcbhJ7mAb4g=;
        b=KxnPqO9NcpJ8nX+W99/AzD3NFV3yjhspCEPk/hnpnKh0yPcpBp/eTLzZinEWO6K0Z7
         OWa7JL7noa9YtiGpQ34Ol9D3znHroEB9WpIqmQKhGLrQrr89hWuRWPpWa/cv+HyCK6RN
         BfDtkLV4i64shEVybNjSO8ItV9fJZGgAP/s6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733948324; x=1734553124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vV39xl6te2UHUQhPJCQM9MYLL2zU7bfjgcbhJ7mAb4g=;
        b=UjLIwxcmaW2TBOIQLqd52sSjoyXLfpVRrco94JFAVAhBzSpbUnZW5y1zIGwAK+1vqh
         hDtdJFgUNkoHbGuO+fTZ3wQUkNZfs/HKLqd9MpYF1febnsGZl7fVjJs0yXI9Mr7Bo6AB
         Ah1IbPNleFN8bAt0S3aohqM95k1pyjUD9Uz+60klNeNegBPi7hY7qcPPJPmP664RW7uz
         g8aqt/V63LX24VEwrg5M1L3Ay6b+aIJop2q2wpN8PACle5LoTLH3RJfcigb9VijIpeRX
         bPP6gQvSL87eHlRIH+KBPU2EzmBFmVnwIVf0SVy4oABS4tlgvTxm7FfFbxjACk7J/VmW
         LpiA==
X-Forwarded-Encrypted: i=1; AJvYcCVEeAR+E52UCzr7PPbv86cM7wrCvW80K/HoHb0pTHcPkXQfnpxROqX+BFbjSmpv7MDRQnVV6YICEDamYaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSSzVrLYr7pitz7DqY/LOPjKaxBDwBTWnmyQ+iYu57d7D39Hpm
	7pM5Hxn8MuM7Ae/YHFrOpril7BmpZFG5/TOCQdaZ2JN/+yEmNQtAmC9Wo2xqSVIzyDTVEW18EFm
	ZyVg=
X-Gm-Gg: ASbGnctZwto4LXye2+i1mTDGGgmadyN9wBRhhvPbIJ7HXk1Ig+jWY3UkBJKf0LIg4Ol
	sMcqcfU3fX8wGBG6S2Q8mqVFRqJWjoalPO9o6pvPUrrvw1VIe+F3BO5TiMhTfFvcUWcN6CjKkSL
	Y8OYBWdFMhJUCY3TpfztbQvOvVwKVQ/971ngIGlrpsbnAHOnn7w4F5Bad1TTgQwaVPnuvDCo5wD
	eILmZEJwGsM1khSMGNWh7LC9a3iy43t7rC5y9MImnerSy9J/604OgydyPq4migp90FXGgIWSCg2
	6Hf6f4CZdBSaqeE/PvIbjHMmlyB3
X-Google-Smtp-Source: AGHT+IHCWkHIKRnQEjZ8B3M/QEPpz+MPEsmBaUpXWnVFBrYFJvIs14Ej5aBtcFXk2XU5NlHVAO4jYg==
X-Received: by 2002:a05:6402:34d0:b0:5d2:8f70:75f6 with SMTP id 4fb4d7f45d1cf-5d433192e01mr4605891a12.30.1733948323811;
        Wed, 11 Dec 2024 12:18:43 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3ef026a41sm5829636a12.15.2024.12.11.12.18.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 12:18:42 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so1044075866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:18:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPcaPfrkDmePaTjBP8QAxfPp18IrBUmO5JC1vqxUOPByXYzeJYqLuuZ5SBnONaNNAZhlcAY07FuNgaRQE=@vger.kernel.org
X-Received: by 2002:a17:906:1db1:b0:aa6:2c18:aaa2 with SMTP id
 a640c23a62f3a-aa6b11e9c92mr347055066b.27.1733948321612; Wed, 11 Dec 2024
 12:18:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1mzu4Eg6CPURra3@google.com> <87v7vqyzh4.fsf@mailhost.krisman.be>
 <Z1nG-PSEe6tPOZIG@google.com> <87cyhyuhow.fsf@mailhost.krisman.be> <CAHk-=wice8YV5N1jjyz42uNi-eZTvG-G2M46qaN7T9VsSaCP_Q@mail.gmail.com>
In-Reply-To: <CAHk-=wice8YV5N1jjyz42uNi-eZTvG-G2M46qaN7T9VsSaCP_Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Dec 2024 12:18:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiC3evUXq8QTcOBFTMu1wsUR_dYiS8eGxy0Hh7VbL55yA@mail.gmail.com>
Message-ID: <CAHk-=wiC3evUXq8QTcOBFTMu1wsUR_dYiS8eGxy0Hh7VbL55yA@mail.gmail.com>
Subject: Re: Unicode conversion issue
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "hanqi@vivo.com" <hanqi@vivo.com>, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 11:58, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The problem is that all the filesystems basically do some variation of
>
>         if (IS_CASEFOLDED(dir) ..) {
>
>                 len = utf8_casefold(sb->s_encoding, orig_name,
>                         new_name, MAXLEN);
>
> and then they use that "new_name" for both hashing and for comparisons.

Oh, actually, f2fs does pass in the original name to
generic_ci_match(), so I think this is solvable.

The solution involves just telling f2fs to ignore the hash if it has
seen odd characters.

So I think f2fs could actually do something like this:

  --- a/fs/f2fs/dir.c
  +++ b/fs/f2fs/dir.c
  @@ -67,6 +67,7 @@ int f2fs_init_casefolded_name(const struct inode *dir,
                        /* fall back to treating name as opaque byte sequence */
                        return 0;
                }
  +             fname->ignore_hash = utf8_oddname(fname->usr_fname);
                fname->cf_name.name = buf;
                fname->cf_name.len = len;
        }
  @@ -231,7 +232,7 @@ struct f2fs_dir_entry
*f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
                        continue;
                }

  -             if (de->hash_code == fname->hash) {
  +             if (fname->ignore_hash || de->hash_code == fname->hash) {
                        res = f2fs_match_name(d->inode, fname,
                                              d->filename[bit_pos],
                                              le16_to_cpu(de->name_len));
  --- a/fs/f2fs/f2fs.h
  +++ b/fs/f2fs/f2fs.h
  @@ -521,6 +521,7 @@ struct f2fs_filename {

        /* The dirhash of this filename */
        f2fs_hash_t hash;
  +     bool ignore_hash;

   #ifdef CONFIG_FS_ENCRYPTION
        /*

where that "utf8_oddname()" is the one that goes "this filename
contains unhashable characters".

I didn't look very closely at what ext4 does, but it seems to already
have a pattern for "don't even look at the hash because it's not
reliable", so I think ext4 can do something similar.

So then all you actually need is that utf8_oddname() that recognizes
those ignored code-points.

So I take it all back: option (1) actually doesn't look that bad, and
would make reverting commit 5c26d2f1d3f5 ("unicode: Don't special case
ignorable code points") unnecessary.

                Linus

