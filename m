Return-Path: <linux-kernel+bounces-563919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BA0A64A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EEC3BB890
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31171243955;
	Mon, 17 Mar 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M/rT9Yt+"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8B241693
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207700; cv=none; b=O+5Uae1dLg+yX/XnQCIFQd+teWcCYzqbViCSk9joH2Cj5pRWDKZUWAcFcWMofRIiFQ93v6X6wTvCg7KZimM+BFlhZdUf3Bd6tg74My205cm9FE4nhEHO02RVgB0/IjJxN7oPRIpUU7/NgZ9IeaSAPD19xeJ56x4B5wNTwCjQiV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207700; c=relaxed/simple;
	bh=Of5SO/kOuDWzPvH7jgul/ATKgBMz1+uJud1GfXwBsTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFoTzstDrXiTsO4ebQ7Vq7Y0CqlwlwYCPno/THB9nk9DpaQdu91OlJciMBviQe0Cs8UYgeLKZdhHpzenSsMYoXOaMr+5haAX8i8/jo4hpmquDdAnwM6bFQPqv4EyfxXWprFufxjf8OnQSMS/H0Vt49ri08t1RFQzzjH3wEpHzBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M/rT9Yt+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39149bccb69so4142441f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742207696; x=1742812496; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l/OCIBGi+QQKAbbyEwfquW9P06SxRFDLjeq98QTwp5Y=;
        b=M/rT9Yt+zbFHSBi1gr6bTDp7jlX3+q/GoHoSFsEI3f8d7CkkSm3Qzg2ex6TIrwPbbt
         L4TtFutxgvrc85StoDbpMjrv7A3q1Li2lLXYSsVrgNK9lm2IeZ8LuvDuWA7kFK+bdWs8
         CjsP+vJR4X4RHXaUazbN2xPmbUq+eoTZuOD9WDyY1GjQrNd4PcTKzEivBsmUxn7y9nPF
         /vAsqN/QJ/g3JU8jjDo3t3jgN2wdLp94mJzj3zIF4YXcU6uwGZtarK64KBerIZetg5RW
         LWsYPb68HeYvN2RhK3Ir1IqvpAqQk7Ck9H7mLaE0VpeDLLwbsgdQ3ORNdaiU+HrqLMKJ
         lcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207696; x=1742812496;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/OCIBGi+QQKAbbyEwfquW9P06SxRFDLjeq98QTwp5Y=;
        b=b5yd6fF8ZPSJKE7K5VnAphI3PVQrxGqubvQjLHOzdclfWoxXVW0fAKphkClasI7r8o
         DLpTD8nyyUNesbY4SOWs0yLkGEnXvIT4336tveccfkbmqPMVy5wQIHl8/DSyyc9Sb/EQ
         sHfGicFmgo26llt+pWF3mq9dDBDUnju70ViOKdVW5//W6jLGx24qeN8n0oAulFm2FDiA
         i/NneWTLyNGO+XszRNVMpPgEz52nYg7GgbJdclj6bBLLQjNquE9z6bPbDuweoT2gehnV
         Rg6nYLavG24yegjpsRBC5x1EpCC4BKl1J42SB1ovRFPwMo6izF8zhcs/XHrnXoa35nXj
         DMXg==
X-Forwarded-Encrypted: i=1; AJvYcCUxAbsWoqHVwo6Pf0GY5Xj+3z5XnuZNJ9/fBr7UqKY0nY16IX7OWq8ZzCfhB/vhgzrx+Aoo0ffS6Ibtj4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx1ofU0woRnQNdgoiqA4UvgZfWv+sSzwfXBM+KL1aJh9aWWj2W
	fl1/edygggnqYzaV5+o8h6RJNQYj6IdqwPY2DD3DX30/Qx0yBfbMRRsy0L6jhVU=
X-Gm-Gg: ASbGnctKAmyrq3umGVrBtAvMVOG6KNgGQyC6H+xgk3J7XABRcOVKsBy+QF0+c/d2A0P
	yqx9iWhy+za/6QG0YDYMpWvwlesVZlbsWnSA9h7j3/T+6XLfZFZ2lqCIat0TJN4Brr0dfqbihUn
	Lz5oSOh17fZ3UyNT9/NxFrmjTX1tOzM7etUAzwwQx5ublJ/ml/pmwWG0s8c8j7QyFrM4VSSrmDA
	E2oWYwLqezGMtyCkSviT1l8y9WP2dJOMY5lgvdkVTWhvN6UQzEz0+0YdQN5ERB3pD7F5Qoj9NYo
	UntXLYYaIfAFQ9Uyk7ZP3+MWJLmxRs9yOhIKOYII4REIUeY=
X-Google-Smtp-Source: AGHT+IFUetDwdpPXZ56ZmMu09Y/xpUhEIp8BG5ohNi+1XsYZzAjOYO0qpVFi5I1pgbI1u+vznJxLSA==
X-Received: by 2002:a5d:64a2:0:b0:391:4231:416 with SMTP id ffacd0b85a97d-3971e9720e5mr13342344f8f.36.1742207696411;
        Mon, 17 Mar 2025 03:34:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c4f9d59dsm14583380f8f.0.2025.03.17.03.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:34:55 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:34:54 +0100
From: Petr Mladek <pmladek@suse.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Kees Cook <kees@kernel.org>, David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 0/6] scanf: convert self-test to KUnit
Message-ID: <Z9f6vYanql2xqbJw@pathway.suse.cz>
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
 <Z9QvRJE0Yun5mfsN@pathway.suse.cz>
 <202503141345.0D3FB87E3@keescook>
 <CAJ-ks9=zFuH=4Sm-zqR_kAuv=fmwpCh__fXgxcoRgc5XuQ46Fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9=zFuH=4Sm-zqR_kAuv=fmwpCh__fXgxcoRgc5XuQ46Fg@mail.gmail.com>

On Fri 2025-03-14 16:50:43, Tamir Duberstein wrote:
> On Fri, Mar 14, 2025 at 4:45 PM Kees Cook <kees@kernel.org> wrote:
> >
> > On Fri, Mar 14, 2025 at 02:29:40PM +0100, Petr Mladek wrote:
> > > On Fri 2025-03-07 06:27:33, Tamir Duberstein wrote:
> > > > This is one of just 3 remaining "Test Module" kselftests (the others
> > > > being bitmap and printf), the rest having been converted to KUnit. In
> > > > addition to the enclosed patch, please consider this an RFC on the
> > > > removal of the "Test Module" kselftest machinery.
> > > >
> > > > Tamir Duberstein (6):
> > > >       scanf: implicate test line in failure messages
> > > >       scanf: remove redundant debug logs
> > > >       scanf: convert self-test to KUnit
> > > >       scanf: break kunit into test cases
> > >
> > > Kees, could you please take the above 5 patches as well
> > > via the tree moving the KUNIT tests to lib/tests ?
> >
> > I think you mean 4? Sure!
> 
> 4 by my count as well :)
> 
> Please let me know if you'd like me to respin with conflicts resolved!

Yes, I meant 4. I am sorry for the confusion.

And the list of pushed patches in the later reply looks good.

Thanks for help.

Best Regards,
Petr

