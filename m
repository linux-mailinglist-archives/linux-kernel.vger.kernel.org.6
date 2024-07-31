Return-Path: <linux-kernel+bounces-268674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D12E9427AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB3FEB21742
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73251A71E3;
	Wed, 31 Jul 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEuyDR5c"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952116CD01;
	Wed, 31 Jul 2024 07:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410336; cv=none; b=JyE2QH9+9tOaQeNMNDahdofkO8NoKqHmoMKsIg96UK1Hp8GDbSPl+0oFMni2oRFsJarY6SitYfwuP9BXrQqK/ehuwI6yyov5ilixkgr+O3fFrHslABQd+ePyg2Nlv/v1Shx0CjvTqdowmCk6IOCd2/yQiIUzwMln5LADEkUPFO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410336; c=relaxed/simple;
	bh=S9f9Hl70Pqzn7nvkWmeWGmOGLynoK+dnWf+0c9gQ7CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TesiD2SWX+tGl33BQvgh1JyS40rxYaEXx1YY+21WL+ajThdInzceTV8QSQpZZeKjgTswd2LazLVSSyZh/QeIEni59SYH8XgxoVFqSc1fbbvI/OXToAAhs1/ikrbOco7PCj+ygxOwlfgw/E6kUt4u5N4xtiLPY41kKgI1ZUajlGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEuyDR5c; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d5bb03fe42so2981536eaf.3;
        Wed, 31 Jul 2024 00:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722410334; x=1723015134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+6hKqvD6dlifbAX1fXi12lyffiK6uAn3NlZANcw0ko=;
        b=DEuyDR5c+GipBljKz0bRYcvsnoJJyNMB7fFh9/RdFpq7WHd58KS8GA1DZZRKzYj/wZ
         6spDKh8fYCDB0tgJ0MjBvsN6+MLnohUfOc888FW2OzeQF1peNZXG3C3bGGpM0qRLISEA
         ZeNjtZhukQ0s3BDXGDAknKj42UnycHFQiOE2AWLzAnYTiLaFc5AnsRlRulB/A8Pl/U/d
         ZIY1HGteDVgQww5xBKhUMwWJRIw2lcKC/qmPdLPkDJmesdYjfEdRKO4HAQnGm8dsQrQ2
         3YgrSSHjgN5QEz7ttovSH9Toawp0SugMd+9v5k4QQUhojtwGAlbd3m+zGrVQnCRKJjCZ
         ATCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722410334; x=1723015134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+6hKqvD6dlifbAX1fXi12lyffiK6uAn3NlZANcw0ko=;
        b=e9myZTp1Gz53XPSJ8n1pWEq1USERJhEvEFuTuOz9C9jM7kyh7wM/fEB/dAOAMbM/m/
         ooBy7SCvKvbANqJ5cNqffdEQzZ2EAi+co9eihioLUgVXDM5dLlHkpxlLmS2gAqVZ/Ue2
         Rw+CcCoFtdsyxcmnsb02WrCc5jfvBe3swSmwVzGXVfN0Pioru5oaIWWAQRDH9lYPdU6C
         UmbprEQyGHOoAwAdCcqXkWcVjHEZhIl/XDB5v1q3IYkb4tjRZnffFyZL5AdwJkA8nl8g
         97Ewa1FrDo9h2i8+JTR/C8YMf/VFkolZDAxXhyX7+fHUOnjuER6w18dA8dxsVFXFuoM5
         98FA==
X-Forwarded-Encrypted: i=1; AJvYcCVIdOYI9YBQ05zvMoAQa5wNn720AFrJEs0skaiTsmhtXRjGmzr7/zMseWRQpCTIIApXDFAlgQ+N2T1yL/E5ZrdrPK7MUM2ClMXbmBlneBdRukeJmtRzha1PcQcYjLTaZiU1Wk0GPEBX
X-Gm-Message-State: AOJu0Ywx8nGVCJRwq8WfijDr3Bnntar4AsOnPAikG8aZu7o38acT1M47
	Bkfonlfwui4PCOB4ynq0cdcVFnrL/Mi7cdcNWg4A+WLzoPuHRFt+MZzHWhrxJYIv/jMFriM4kMr
	4SY1sg21kE5UwX49M7xidfJ7dh2c=
X-Google-Smtp-Source: AGHT+IHNCUb+CWZAHtHj/G+0ndY/4kxGpXCMzxYBx6jjsORnqFOvtSJmEKY8qPDEa9RTAgpqNXz3w7YQiH526a/C1wY=
X-Received: by 2002:a05:6820:1aca:b0:5d5:b49c:b6f7 with SMTP id
 006d021491bc7-5d5d0ee9fb0mr11555022eaf.7.1722410333613; Wed, 31 Jul 2024
 00:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719041400.3909775-1-dzm91@hust.edu.cn> <20240719041400.3909775-3-dzm91@hust.edu.cn>
 <87o76f98lr.fsf@trenco.lwn.net>
In-Reply-To: <87o76f98lr.fsf@trenco.lwn.net>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Wed, 31 Jul 2024 15:18:27 +0800
Message-ID: <CAD-N9QVsYGwVOdnnnzUopDk9sr4gOhgjrJFN3muijvuUK7Q6pA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] doc-guide: add help documentation checktransupdate.rst
To: Jonathan Corbet <corbet@lwn.net>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, chengziqiu@hust.edu.cn, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:44=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> For future reference, a sequence like this:
>
> > +Then the output is something like:
> > +
> > +::
> > +
> > +    Documentation/dev-tools/kfence.rst
>
> Can be more concisely and legibly expressed as:
>
> > Then the output is something like::
> >
> >    (literal text here)
>

Hi jon,

If I understand correctly, you mean to remove "::", right?

If yes, the rendered version looks very strange, e.g, the document -
Documentation/dev-tools/kfence.rst will be rendered as a file.


> More importantly, though, this file:
>
> > diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documentati=
on/doc-guide/checktransupdate.rst
> > new file mode 100644
> > index 000000000000..dabbf9ecd187
> > --- /dev/null
> > +++ b/Documentation/doc-guide/checktransupdate.rst
> > @@ -0,0 +1,53 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Check translation update
> > +
> > +This script helps track the translation status of the documentation in
> > +different locales, i.e., whether the documentation is up-to-date with
> > +the English counterpart.
>
> ...lacks a title, so it renders strangely and inserts inscrutable stuff
> into the doc-guide index.  I have fixed this, but I am not entirely
> happy about that; this is a problem you should have seen immediately by
> looking at the rendered version of your new document.  *Please* be a bit
> more careful in the future.
>
> Both patches applied, anyway.
>
> jon
>

