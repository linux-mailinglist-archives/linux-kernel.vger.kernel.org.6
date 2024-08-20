Return-Path: <linux-kernel+bounces-294594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C26958FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9BE1F22AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FE41C57B4;
	Tue, 20 Aug 2024 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WGVh8wNh"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675245008
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724189980; cv=none; b=gCEK11qkcjTOg6JCga5D+6uhp8qX060jBccCw8LRYIvsBhJXy1FW4AO832vJcJk4hSLjpEOgaD318js1Ptsh9OL2QDfyFEgd49qMOsG/OEkWU1+i/aMqAGup7fn/p1npdj9FLk/KZboq8CcaxdjyaKJvuMKe9GzKCOV8GusZ/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724189980; c=relaxed/simple;
	bh=zPen0ZDsMIGVeT7oJMVDG1CPWwqKsFrBf0fJYTWFLXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIfto69B82mhnGXsRr1g0FVuQUGodUH9ZlVOB/+9pSFCA8GjoGzi6MOobzmxcG0gaE+t5IYSpTZWnuW7Es9hFM/DnO610rC/DpEsY7+4Q5d1mjhm/Wez8+ieakQlBoOtDCMLq21zndgEhXo0kQjlyz3gOMrrosSkXOoDw+3P+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WGVh8wNh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a975fb47eso690267266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724189977; x=1724794777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B/qBbIdE12tBC8jy3M3AIScxm0SURUOtfr0PSYL5bF8=;
        b=WGVh8wNhJlFpRdnpRsi/0EsmgfuwUaWKiGCtG1OMrQ+qsY00ztrm+jtGdYNcno10zm
         sOsxhllFgrn2f3CCiVRzEtMI2rdLPyHdWHW5sghsHsEp+uwbReWCxSLoZ11IJIp2vTsU
         JQRgiuRrnEWkcxDg5D2FaMmQa8QQSScssgNQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724189977; x=1724794777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/qBbIdE12tBC8jy3M3AIScxm0SURUOtfr0PSYL5bF8=;
        b=bDqhNmzL++yQofGXDZWnYTJzq+w25MRNhVhafl6db1DeqiNykaTyPWz3IeW3CmHx1b
         5YsBmW2XcQFhlrGph7XBy5K6FfuI/3K1U8EiWHF6HZ+Lzki20ab7/h8wy0lT+BIxBCc0
         k+qNub3E2w7WztHRd1Eps+9gYLgWhSGJJgxLXhsHvX4mdj4C0LvcZrw0fAauKlza4Mxw
         VKuhpy6/vK68+LRsv8q8CkxARUn/KmtoXJHKCNyvZQQeJMwsm3oT/xwWZESyYO7qkviW
         /SD7Q3Qbh83qWSq6uD9he0agrAuIU7V33sLNqwWUAfBo8eF084BcvwgYXpCilGG8+Z9c
         iwcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdl8rwStmzafTixCatp0rTihD3AKoRNtDTZOMYFXRjrz7+wG9A07oApHMnhACTfHLzb3Eicpe0aWKjnyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYBzQWpoFSG0uAcq+VxvN+2ugCJhKS1uP44gJk7xC18jlsDGEG
	Z27uj6rhkQ7LORjYIu6ZkktMBcS6nNgmaEzyCq/uSPt28COCsoWfJrFWpr+97U9iHY4fc5z3l7a
	QbaYOCw==
X-Google-Smtp-Source: AGHT+IHV5atTFMjDhrgZjV2Fdvbu8jkhqRX1zQ0zJJXoLaKK82LujiwNtMgI6bqIqkjrQyZAf74rvA==
X-Received: by 2002:a17:907:e61c:b0:a7a:c083:8579 with SMTP id a640c23a62f3a-a866f9b0ae1mr24486066b.62.1724189976833;
        Tue, 20 Aug 2024 14:39:36 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935663sm815455166b.121.2024.08.20.14.39.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:39:36 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so4557404a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:39:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTx3DHyGsePEPoyVszUJCTnvUFuKzGgaAU53D9upD6InmWql2ASj6LVSQwDtNETFlalgMr15hRs48ythQ=@vger.kernel.org
X-Received: by 2002:a05:6402:354d:b0:5bf:b29:6eb4 with SMTP id
 4fb4d7f45d1cf-5bf1f164130mr60685a12.21.1724189483542; Tue, 20 Aug 2024
 14:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
 <87y14rso9o.fsf@mail.lhotse> <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
 <dff57198-7955-ec09-8909-671982834673@landley.net>
In-Reply-To: <dff57198-7955-ec09-8909-671982834673@landley.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 14:31:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
Message-ID: <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Rob Landley <rob@landley.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 14:17, Rob Landley <rob@landley.net> wrote:
>
> Hexagon also has &&vdso_page which I don't understand (but have a toolchain for
> somewhere to at least smoketest...)

The '&&' is just a typo. It should obviously be just a single '&'. As
mentioned, the only testing that patch got was a x86-64 UML build
test.

Fixed locally.

               Linus

