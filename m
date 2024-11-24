Return-Path: <linux-kernel+bounces-420221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2F59D7708
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 19:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CD4163462
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F96613D52B;
	Sun, 24 Nov 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JUwxwAdt"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052E3201
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471246; cv=none; b=F14XNIOTk+mpiWOQBhzDbaYKuq9T17g2fMj4+4JbwzdgeMPCLm/SqcKxsYt/w5Fp2XltGE4PfGX2bxOh8pAlMacc28E9kdrauDAuO1j4XRiNQmk5PoVNPK7zafYJaoGbTne+XS4+VBrGqcPcRHtvTq6A8+ogb2mky9hLVCdiGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471246; c=relaxed/simple;
	bh=MHRc+EZrsf2NABDvI/J/e1unkMv/9URuKXuZyw9v07o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdcNGIgk16EpNRj77ynv7jHyUhqxhJbS+G14Gb/3srNWVS73L3J36z/oqeH3/E2sjRXBJ1jW90QrKs+5cgC58yYXaBuCwRUP3r65jKnLLUHJzjReKCktIGWU/bEYGtGOug9MWqjET5EirtPQd/yZIbFUMklEAYW9HI3D2fJXJvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JUwxwAdt; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa549f2fa32so74508266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 10:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732471242; x=1733076042; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eFtkAkE9w9ozdnjm+X092ocX1iqcO1qOEalWj4WqRqg=;
        b=JUwxwAdt+wvtHyPXeKHblU0pijfriI+oSjawg7k2ptOavQ6clq3SqOz/GNVwtFW6+w
         8V4KwuD27TXotwJsJ4QeBWKN3GAq+oZ1ZC7+NWbXEP4PYuUPbiGZKoW6ZRZslytibk+1
         ZZHhDd1JHSVpDRpdHlWsuG5z7le6MS+ueUtog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732471242; x=1733076042;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFtkAkE9w9ozdnjm+X092ocX1iqcO1qOEalWj4WqRqg=;
        b=MpaYRxnN7y0r3zDkqXaQ3PwbHp7hOw6wSuqGO3EMUGIC15e1jwVk2ClfhVNcVzSeRJ
         OHNd1r0Y4STCrjWdg7TUjua/jGDMGDg6DL9XrrMUlX7OyVqwD52GCW6UdzZf02bXOCOl
         q7z9L3GZ5FDr7ZtSdqScwib8kOG/ukQszYjX2S3rAIRqLdwy+kJSuTLdr1it5tfXo56e
         j+zTwY+PZ1zN+f7JGOp/O6SJz0iSX4LxACOsnnIS9JjhMBE2Hec0TNLljz/8bam5b4Rs
         0PZRkIvVo+DOB0wIscMgNyqoKbtfA5ZflSMqE0jYr+BHBvDtt7LvO7CQrrxcKCkSpY3A
         fZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXutZzH69moab4ADBoEyeMoSSc8weqMrmFYCnLQ8TN5gHscA77/QGdwLEj7q5C4/HB2v6Kzxm9qdzUkWUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEHBfN+PFR+Egl/Ff/xsVvQeZOXN7vwT/9k/5fQWfkqMrQqbLh
	feyMt0TFmqf78SmrTPS8H0OkUOFv0iE4UKkDzx60aopzfrJIiylUg1wVmyQNfYNkPjcLeHgL5Dk
	SuXm0PQ==
X-Gm-Gg: ASbGncvT6rLYCZg9z1PZuda6ueHWVx6N5wP9+wG0k5aejGrFhAz1nKwpeeTgeeHeCFh
	wb4cfD6mkSXMkJvsa052gRZUZVFRdeLQ1xtbuRZPU2dudISmYv8bP0DA6YzPHD4NoskJTIKoaue
	xSQkXNJuQQ9J3kiLULdBc5eeKCBqYf8kN/WjMBSup2GnylnR4Mk96dH0YQq020+ba4n/2PHHAsi
	ALjs9ftaP5t4FYoNu8Dp4dlUVPYsbYmTFL+kFfdY9yJz+HadSKex+jWkScBmh7uc2SMcYqA2CTi
	WJEBCMjglXs77GB4eQ2WY4pQ
X-Google-Smtp-Source: AGHT+IE7HxYEMezTZ7tBOd2+bJLz0vay+L/GEQ0KmrIOxqP1eXDM7lHDmoVw2Rn26kZaik5j0w25sw==
X-Received: by 2002:a17:906:32d0:b0:aa5:37b4:cd60 with SMTP id a640c23a62f3a-aa537b4cf15mr368893466b.6.1732471242410;
        Sun, 24 Nov 2024 10:00:42 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa52e45391dsm254182266b.60.2024.11.24.10.00.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 10:00:41 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cfcd99846fso4943774a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 10:00:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU73CYElI+RyCvGSFJm92FIq9fSafvcC1pU/KKyI957KXRgOmEnISamWZCdNMYv6rkzVaqSuvuXtCI1GBM=@vger.kernel.org
X-Received: by 2002:a17:906:23ea:b0:aa5:4731:1eaa with SMTP id
 a640c23a62f3a-aa547311fb0mr240536466b.50.1732471241090; Sun, 24 Nov 2024
 10:00:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whoEWma-c-ZTj=fpXtD+1EyYimW4TwqDV9FeUVVfzwang@mail.gmail.com>
 <20241124-work-cred-v1-0-f352241c3970@kernel.org>
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 10:00:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi5ZxjGBKsseL2eNHpDVDF=W_EDZcXVfmJ2Dk2Vh7o+nQ@mail.gmail.com>
Message-ID: <CAHk-=wi5ZxjGBKsseL2eNHpDVDF=W_EDZcXVfmJ2Dk2Vh7o+nQ@mail.gmail.com>
Subject: Re: [PATCH 00/26] cred: rework {override,revert}_creds()
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 05:44, Christian Brauner <brauner@kernel.org> wrote:
>
> This series does all that. Afaict, most callers can be directly
> converted over and can avoid the extra reference count completely.
>
> Lightly tested.

Thanks, this looks good to me. I only had two reactions:

 (a) I was surprised that using get_new_cred() apparently "just worked".

I was expecting us to have cases where the cred was marked 'const',
because I had this memory of us actively marking things const to make
sure people didn't play games with modifying the creds in-place (and
then casting away the const just for ref updates).

But apparently that's never the case for override_creds() users, so
your patch actually ended up even simpler than I expected in that you
didn't end up needing any new helper for just incrementing the
refcount on a const cred.

 (b) a (slight) reaction was to wish for a short "why" on the
pointless reference bumps

partly to show that it was thought about, but also partly to
discourage people from doing it entirely mindlessly in other cases.

I mean, sometimes the reference bumps were just obviously pointless
because they ended up being right next to each other after being
exposed, like the get/put pattern in access_override_creds().

But in some other cases, like the aio_write case, I think it would
have been good to just say

 "The refcount is held by iocb->fsync.creds that cannot change over
the operation"

or similar. Or - very similarly - the binfmt_misc uses "file->f_cred",
and again, file->f_cred is set at open time and never changed, so we
can rely on it staying around for the file lifetime.

I actually don't know if there were any exceptions to this (ie cases
where the source of the override cred could actually go away from
under us during the operation) where you didn't end up removing the
refcount games as a result. You did have a couple of cases where you
actually explained why the bump wasn't necessary, but there were a
couple where I would have wished for that "the reference count is held
by X, which is stable over the whole sequence" kind of notes.

But not a big deal. Even in this form, I think this is a clear and
good improvement.

Thanks,
                    Linus

