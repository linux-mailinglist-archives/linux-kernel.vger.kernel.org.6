Return-Path: <linux-kernel+bounces-442019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023249ED6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96B82825B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47512210E7;
	Wed, 11 Dec 2024 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q/fYLsal"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51B82594BD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947146; cv=none; b=pboWSvkwgWShIXBTGStdjM1jXP7fD67P73Bl0EIEi4DJ2Mw0oIefi3JiLTob+iWKqB9wlh0h5jPGEoKMM8gg+SiLWoHUxFYipDveu+PMA2bWjtkOBb6n8pkqlB+wjlofLqNgoAmlOONXc0NprgJ9T9g/X0OPRwMjGHs7+WchweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947146; c=relaxed/simple;
	bh=4rKdBuzfZs27aH5czds2mZCgZgRoAxP5dCRWuV8cFcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6nFB4yifX/fxJVhLzRP7THF1C7uL8QQpeK89G/qQfAWdd2+4DI5icPtLQuyx9lG4lCPMHBy++B22iRmjXiafnkMJu6Ukwh5xpQIpk4d4HiayECCkJVAUfpqeYeiWNCrqoRvnBpTkbgg1nE8e10xfJpdGeIYLOPKwrLgV0sad2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q/fYLsal; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso2045989a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733947142; x=1734551942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gFl4YOIRUwrohBAoCKzlwCbBAlsCsbqyA/+GsvWzYdc=;
        b=Q/fYLsali4/e0RQ6Tex2vqQplLVrboWpyg8yG2TW08GAbwfdyiEFa4+TgV5K9q5GBd
         IlTjQeuiS0P5QR27qfayVh9FBvwDp3giM2id79PltoewKPyJKGgq0OyHDykEmYtQiatv
         ui7dJBtLh6i6qizvxUPHIPz6eI4ZdLYAP7KDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733947142; x=1734551942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFl4YOIRUwrohBAoCKzlwCbBAlsCsbqyA/+GsvWzYdc=;
        b=mZJ4Kmy485+Dn6ACDgy5bGl2pjdlgzyOhrtqqYHE95g+YAdv/1MqC+gXS+Q+5H0Nkg
         1EVdO07Gyz0lL4AHIxrUy1mLuTZEmQ0RDCAqpCuqEuBUsgNLE+uJS4uR1i029RuFbdZM
         zfZjVh+WGhIdStNk8uC0Otvl4/3cN5LLjdpk/y6Kx9Uptk2Bc5TZWQMRYFhc35UaAq5b
         lx+1iYBVFodv22tk0oybXScUrTmPByEqM/a4QPg22c6XddQQmAFqEjb1lCII7CqY6hHq
         JGKsnrkx7Z4Wf367wxpbtNge3cB52AQG4cHavZsjHat7zGAl5mAgrCxo6m6tkzUdGQdF
         YbbA==
X-Forwarded-Encrypted: i=1; AJvYcCUBu2sc85CnRcJY57kxqwNBfmIiB4kECQamyNRGbVYJzFjGMm3bIBu5itnK/WCVgIVRYrog1EXwlPzQ0Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN+PPein94KTtGO5pqdMsMDdAFaX8fjW7UUlw7TOCWY+L4hPOq
	drXI9hw2Cbdaj1eMIhzg+C+4GzaHLTKT0biX2OZOLBjMLjbT1agcK1kxb5nnjh+QVGNDQM6NOoc
	jeuI=
X-Gm-Gg: ASbGnctmlAFyXKb0/8aSQuoaxC69sHVgOxXTd2Txlh27lR6+x3h64e8i/+8uDHzKlha
	LuAcW4r1zTknyGaLtlTAFocigxCMUDvre8Deao+LeRpXsijkq3QpyAvMnyl/8hoSxmU/3Wlrjuo
	J3j9z8+S8OOrmhg1nAGADtJ2CcMvwWDh0bMuXIUN4Rl2QRa+HltD8UifQ2+QSGQy5rtRGolZXHV
	9q2nDW4fDWFF+Bw/9HuS41qSGAHkE0vVoBNSjxskK4+r2Kc5CKOw447jHumR4vG13X/W6uPLSJv
	r+cG0hXERmnZvX/UfwVEZNcWywFW
X-Google-Smtp-Source: AGHT+IF6tilVIJ2UWHcu/7FCQ0LNVSB0MXPgQ6BAs//3EyVYFiDogMm0DVQyffu5hNyfjcXvoXnn2g==
X-Received: by 2002:a05:6402:5212:b0:5d0:e461:68e6 with SMTP id 4fb4d7f45d1cf-5d48275d653mr393656a12.17.1733947140303;
        Wed, 11 Dec 2024 11:59:00 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3df2fc65bsm6678960a12.54.2024.12.11.11.58.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 11:58:59 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa6a3c42400so203635666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 11:58:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVshzfs3md9b27hbhx2EgOR7CTvU6ukq1lnw/aP6vj7re+mm6rsOzGZ5NeTmY3RLVC3120uaJZCifyl1+o=@vger.kernel.org
X-Received: by 2002:a17:906:2929:b0:aa6:489e:5848 with SMTP id
 a640c23a62f3a-aa6c4190904mr44750866b.25.1733947137917; Wed, 11 Dec 2024
 11:58:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z1mzu4Eg6CPURra3@google.com> <87v7vqyzh4.fsf@mailhost.krisman.be>
 <Z1nG-PSEe6tPOZIG@google.com> <87cyhyuhow.fsf@mailhost.krisman.be>
In-Reply-To: <87cyhyuhow.fsf@mailhost.krisman.be>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Dec 2024 11:58:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wice8YV5N1jjyz42uNi-eZTvG-G2M46qaN7T9VsSaCP_Q@mail.gmail.com>
Message-ID: <CAHk-=wice8YV5N1jjyz42uNi-eZTvG-G2M46qaN7T9VsSaCP_Q@mail.gmail.com>
Subject: Re: Unicode conversion issue
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "hanqi@vivo.com" <hanqi@vivo.com>, 
	"Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 11:46, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>
> 1) The first is to revert the patch and fix the original issue in a
> different way.  That would be: We would restore the original database
> and treat Ignorable codepoints as folding to themselves only when doing
> string comparisons, but not when calculating hashes.  This way, the hash
> will be the same, but filenames with Ignorable codepoints will be
> handled as byte sequences.

The problem is that all the filesystems basically do some variation of

        if (IS_CASEFOLDED(dir) ..) {

                len = utf8_casefold(sb->s_encoding, orig_name,
                        new_name, MAXLEN);

and then they use that "new_name" for both hashing and for comparisons.

Which is really really annoying, not just because you hash all these
meaningless conversions (aka "I write buggy crap and call it a
filesystem"), but it also means that now your *comparison* has to deal
with the fact that the name you are comparing against isn't the
original name, so the code in generic_ci_match() tyhat says "let's try
the simple exact match first" will fail too, because the string
comparison isn't comparing the original raw data - that almost
certainly matched.

Because even on a casefolding filesystem, 99.9% of the time you give
the *matching* name (think extremely common things like "readdir ->
stat" that is done by not just "ls -l", but *any* filesystem tree
traveral).

Soi the whole "let's corrupt the filename and then hash and compare
that corrupted version" is doubly wrong.

Christ. I really really hate case-folding filesystems with a passion.
The incompetence just fills me with red-hot rage.

               Linus

