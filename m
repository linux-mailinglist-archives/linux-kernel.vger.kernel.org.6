Return-Path: <linux-kernel+bounces-323409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402B7973CED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DD31C21879
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8F519EEDF;
	Tue, 10 Sep 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hijhZNxZ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B0812D214
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984305; cv=none; b=fAkGCdftUm2kP6O2bPnmYbDXjgdz5ckzF+aymMQjy+r723WzXROz+T2Q9GoHsvKkIo36Ljf0tt2fUTG5hu0wJt8zM/0gFuOJVL+gBwL+Ff/GCQoqYzQpU3/v44sPE0iVl3yR2oKWjhWfMLT1LBzodEX3AoB0RzxmnHEOMiZbseU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984305; c=relaxed/simple;
	bh=P1siuBJeF8xo/ZxDywGlXBwlCjIfSaO4qNxoqL+UhoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6tEzWTGQvIncvUvwcgfja2gE+7UjsLAAMU9sDLI3Ghq+0mVE5LTbWVt2sBOCxwEk/ZFao5nsRXnREezB1vnkynqI7x9SHuvx/tWDMSlffwokZE+fuO3fzxGpRY68kiriwJACPRi4lQaJJrMajfwgY6C0GM/Ow5uaJFBbrypaUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hijhZNxZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20551eeba95so51111805ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725984303; x=1726589103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P1siuBJeF8xo/ZxDywGlXBwlCjIfSaO4qNxoqL+UhoM=;
        b=hijhZNxZgelaIRuF385vBIakzEyEOXTWJFgckW8mr2Ckn8UfhZ/+jZn8GpPKH4Q3ds
         CLbOFy1ghn7wzO0pPNDgHaM6E1w1t4Oht9g/3H+z3VB6bXrqALv5JNl5Fh55syLAmVFO
         in3faqKEmFOkyJdMpeT7Nic5L7kZQyZfk4aSKQ/yyXIoTyK4fnE7fY4yOMq2DT10HlRf
         2SEc4Iaoyov6lrLD3Yp6+Wf3MDA0Cgo02Qxhu0h6/Cc//kOMbungW/0mkpFVjxWULRLd
         NCO9W/h5Zy7WV+8kepxq49hcHndYRs/Kv7rlv5c4fRjvpkQCjLFkk3kQ6m6rVTNSjZTB
         3gJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984303; x=1726589103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1siuBJeF8xo/ZxDywGlXBwlCjIfSaO4qNxoqL+UhoM=;
        b=uQSNCnjunVazEiHkIgEcfkdFFO56g1C+auzrNjQ/x5gA+OogK/sGqAqSxRSRfGGy43
         sRDBGZm0aonxd8/sinK9AaPEwObNX5j5bVV1uNj4CTMIzNq0lDPUYTuX5RrArkrKnl1x
         PjMF0IsWeU9g7PXl9DsB6DdbhpdteTMaPX0joxGkTDuZSU1BAZTLz8M/2+2V+ymuPfyw
         wGDW6YRHQhh/BhzTWhJbsj+yCRPpdXCGu9bQDO3iZXM9j0NTwEbBhAcOYCRgWXWMK8Ba
         uFL0nEMh1Q9ik17RGI6n33KA0zQ+Hikh0+VS71nRz+kcBMFQdfuMrSCjH+BfvhYetP4e
         DWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/AvuDgR7FOJomVyhgobG3ExcorCUtKtNE7cnBGhn8oKfTF3btN5KvDpu1xc86vEaqzBAL+KuTblgTdv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVdSCFgXGxoCXs7xADirsyq6Z7VS5Z59X9K/k4rBNaskPDq0jt
	vA4xov6zNw63McvEgENKa3TLfH1YoARwh4rSB2fhH6l0gWydcl2+b/R5g+G/O6ejmPKdj+ha+Xz
	QUmH4zstKiUDvaS+b6AgRU9tEEKKj5gnTvnlj
X-Google-Smtp-Source: AGHT+IFvVBFjHyLjR5hkeqb6+FEeY195/yDcL/c7agXr6V6jTnHtSBq/nfbI0CnQlcXeCOYrl3qkTDkixaro/UZ0pWQ=
X-Received: by 2002:a17:902:ea02:b0:206:b399:2f2f with SMTP id
 d9443c01a7336-2074c706ff9mr17118845ad.47.1725984302684; Tue, 10 Sep 2024
 09:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909012958.913438-1-feng.tang@intel.com> <20240909012958.913438-5-feng.tang@intel.com>
 <4b7670e1-072a-46e6-bfd7-0937cdc7d329@suse.cz> <ZuBURfScdtDbSBeo@feng-clx.sh.intel.com>
In-Reply-To: <ZuBURfScdtDbSBeo@feng-clx.sh.intel.com>
From: Marco Elver <elver@google.com>
Date: Tue, 10 Sep 2024 18:04:26 +0200
Message-ID: <CANpmjNPOO1kj62wRUJC=yZ4qhvHaDDTpH68UQ-MT_jZU3Giaeg@mail.gmail.com>
Subject: Re: [PATCH 4/5] kunit: kfence: Make KFENCE_TEST_REQUIRES macro
 available for all kunit case
To: Feng Tang <feng.tang@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 16:14, Feng Tang <feng.tang@intel.com> wrote:
>
> On Tue, Sep 10, 2024 at 03:17:10PM +0200, Vlastimil Babka wrote:
> > On 9/9/24 03:29, Feng Tang wrote:
> > > KFENCE_TEST_REQUIRES macro is convenient for judging if a prerequisite of a
> > > test case exists. Lift it into kunit/test.h so that all kunit test cases
> > > can benefit from it.
> > >
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> >
> > I think you should have Cc'd kunit and kfence maintainers on this one.
> > But if that's necessary depends on the review for patch 5...
>
> I added Marco Elver, Shuah Khan, David Gow and kasan-dev@googlegroups.com
> for kence and kunit review. That should be incomplete, will add more in
> next verion. Thanks for the reminder!

Reviewed-by: Marco Elver <elver@google.com>

Glad to see you found this macro generally useful. But do await KUnit
maintainer Ack as well.

Thanks,
-- Marco

