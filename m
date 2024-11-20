Return-Path: <linux-kernel+bounces-416077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3419D3FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411361F226D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3D61552E0;
	Wed, 20 Nov 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6/1nbja"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65B6153BF7;
	Wed, 20 Nov 2024 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119623; cv=none; b=JKy6OIFFwTP6kYjWc+VGbKYAiYn3j6LqBaJX4WZ89PvVLdldXIRBEBGexqUWeQTRe7GZuIX7HusBktJn1/mQNFz8Zh2gEIch2tPXv9e715bHT5W9pqfHL1ZjRr2wgw1088HNhZNsCK2ZC6Bfybi76c3qRNU1UkTE7TxB8GPjYZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119623; c=relaxed/simple;
	bh=VhY2vIhS0JZOOhKsqCqkIA6timPyzX/pJA8LnkOESZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djnOKlyqS3xiaG2aQStzjcn3+YOsbTFLAXy2sV0lIT4GnYPW4k+zddRnx/edPx/V99twr6GMHaDkMXph1/L1jBwBV1hzNzYZqIy9jhyTC0uTDCw/xMhNRo+/SgmLdQWvmEHnN4ytHTMh+ULDq0AZgqFbxXslmPjdRHfBuvSzjTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6/1nbja; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b152a23e9aso129856385a.0;
        Wed, 20 Nov 2024 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732119619; x=1732724419; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wjGuNENkASJ1sxhnaZ8RtRQI4flY7dzE8vwBtkKiIKE=;
        b=I6/1nbja3bJrdmGuLUkw8OvPb/s0o0Ih42de7HTB6WQkKPpv7+vYVrwRdT/pPcuiAw
         2fyHIYtWGa1b8AVNA+AD2kKNEkbFFkrFQ/ieyWMqOMw98Zz3kjlxubH76NO29j4xqUiS
         6ToL/nwdx0guYWaKVrLRwDxqeqQhzoFu98HMKazQnOPJuZu/CFQK1PqAegAOXkpTvMvS
         7oDmlkCR4wd+/ww5jDat0v7fNujjKY0cLoIyzuxnRynIW7ElzkynpZEzZpovSCxPRDWZ
         +e4LuaCY1uWZDHyTiIh0RTiCnQAK6J8/5SFbk9/o++oDv/cz/Slio+ARIJhqUF1cczfz
         r/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119619; x=1732724419;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wjGuNENkASJ1sxhnaZ8RtRQI4flY7dzE8vwBtkKiIKE=;
        b=rqrbXWIG9fqF6xLysZt7sz0xQMZfyXGS1lnUCJYJUsTcUSpJGpNAUmd7OU+oNIq3Wy
         jMuDIVMqv6Nskg09pA1QBD2oaxthJu3wrQZR6ceNzsHXw1LfAADtv4OnWN5yatjnbhuv
         f275OM0zW5GBluf+i8GM2COerAslUOapDm7rmvBCsT2g1Raee2VqPicr1SujhARMxZHN
         unXeHQSm9K5EuZLZQdg5enSrFi+/ouaQtLmjkfvjNLJS5oWvMqXGlsJMZg3v2ip436Lm
         0gCxxxJmqX4moSHRw60Sd8faNndOJl9CvTv5FG1r1rUS4DPkk+mbuTl29Fc2qRwm90Xi
         q0iA==
X-Forwarded-Encrypted: i=1; AJvYcCUkqzA5uGXcExpYcFH7DtXawcXvmwA0ozlB9eKpxNhqj7ocHUumvZngzseucgZaabHzzqvO1JxFUB63VKhizJw=@vger.kernel.org, AJvYcCUzTzI/b4PiN7mn1f1ie4s5YCn5iQ7VISrbZ9Kx3du24Z372v5yH7F2Lw+gJpT2p8DtHF+4xTKVLCmsA5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEQ4YKqCuTFa71dyfMrLoDoFvEjt1YMg6ziDBTenrr6Th0tLz
	cPaytAsAZRsJdEv5p7ab/9Znl8nG8ZSjz972riw9HLWEH3CaFkV+
X-Gm-Gg: ASbGncvbs7gP62pXtTHqN7lBFZk4eGj5HZsfeT/h0oUnJGvhacA/5/ZjkWSWv33NAIi
	m0UlvcsDGXz/fCiif6accdaE3rUsBpT8i9Q/ro8gVwLlVZS0MPe/i2pEuJ0dXfkT3nU2CkYaLpn
	toRWM6dHjxnTIdPEf4VxNhvE3QttziiqEYtYWjgTZVAFWD8DtBsWu+U4ZwSpK0BPbfJOufGCGJz
	xWUR6zLtDr5pl6Xi486xavD1oioPDCYMLIeVaSRaEryezNF18TW9xsSVtH+h14pzWaOC91oJSYb
	qzGub+4y1UNJbnxFeZLDcpCI11hItaoXQSq0fbpn
X-Google-Smtp-Source: AGHT+IESUNifRorN1RtbZ2H8fTui7Tpz5Qsemtxe3GpYAt5OStXssjwkj6m6pYWlMFs31ypkbCc+5A==
X-Received: by 2002:a05:620a:3727:b0:7b1:557c:666f with SMTP id af79cd13be357-7b42ee1c773mr444630585a.25.1732119619586;
        Wed, 20 Nov 2024 08:20:19 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b479d90cc5sm112732885a.59.2024.11.20.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:20:19 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7A99C1200066;
	Wed, 20 Nov 2024 11:20:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 20 Nov 2024 11:20:18 -0500
X-ME-Sender: <xms:Qgw-Z270AMtHTgdSBQr34pxsq5Bnp4oa1dOxiNo9opqvlregUaH2Kw>
    <xme:Qgw-Z_4CYUypaBLfNqgQaK4Cb6xbO-lj4QMg8eNKZr7UoMjO31F69l2JT10iKf5ao
    l6UupALTgqSubUpnw>
X-ME-Received: <xmr:Qgw-Z1fShqvTbb-YxMsVu_p6Km1fjx6zcr6QY9oDgRrbG-waSEkgcgH5daM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffg
    heegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthht
    oheprggsughivghlrdhjrghnuhhlghhuvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhi
    hnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhn
    vghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:Qgw-ZzIleciNYYcUoMQUJPhWBwX6O79jSgtlljcSzJhaT4dVwX19vQ>
    <xmx:Qgw-Z6KGWxW8JzIEAyRxf0x6TVnlGiocSHJQqjNuYCWUf_yii_FfkQ>
    <xmx:Qgw-Z0x7LG2gyeZrc7Z1zEjEUqMBKzFc5rDhISRzcLoVYt0pvoshig>
    <xmx:Qgw-Z-JYZHcSNCb9A9KET7Kn5sAEhrOoK7ooXxqFL16zWzXPwWZ3vQ>
    <xmx:Qgw-ZxaxnfLlDGusSGQILVFKsD02EQQlDrGVxUHmFg55FPUwQj1XLRAD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 11:20:17 -0500 (EST)
Date: Wed, 20 Nov 2024 08:20:16 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	airlied@redhat.com
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page
 mappings
Message-ID: <Zz4MQO79vVFhgfJZ@tardis.local>
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <Zz1sHZLruF5sv7JT@casper.infradead.org>
 <CAH5fLgiyHGQJxLxigvZDHPJ84s1fw_OXtdhGTd0pv_X3bCZUgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiyHGQJxLxigvZDHPJ84s1fw_OXtdhGTd0pv_X3bCZUgA@mail.gmail.com>

On Wed, Nov 20, 2024 at 10:10:44AM +0100, Alice Ryhl wrote:
> On Wed, Nov 20, 2024 at 5:57 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Nov 19, 2024 at 01:24:01PM +0200, Abdiel Janulgue wrote:
> > > This series aims to add support for pages that are not constructed by an
> > > instance of the rust Page abstraction, for example those returned by
> > > vmalloc_to_page() or virt_to_page().
> > >
> > > Changes sinve v3:
> > > - Use the struct page's reference count to decide when to free the
> > >   allocation (Alice Ryhl, Boqun Feng).
> >
> > Bleh, this is going to be "exciting".  We're in the middle of a multi-year
> > project to remove refcounts from struct page.  The lifetime of a page
> > will be controlled by the memdesc that it belongs to.  Some of those
> > memdescs will have refcounts, but others will not.
> >

One question: will the page that doesn't have refcounts has an exclusive
owner? I.e. there is one owner that's responsible to free the page and
make sure other references to the page get properly invalidated (maybe
via RCU?)

> > We don't have a fully formed destination yet, so I can't give you a
> > definite answer to a lot of questions.  Obviously I don't want to hold
> > up the Rust project in any way, but I need to know that what we're trying
> > to do will be expressible in Rust.
> >
> > Can we avoid referring to a page's refcount?
> 
> I don't think this patch needs the refcount at all, and the previous
> version did not expose it. This came out of the advice to use put_page
> over free_page. Does this mean that we should switch to put_page but
> not use get_page?
> 

I think the point is finding the exact lifetime model for pages, if it's
not a simple refcounting, then what it is? Besides, we can still
represent refcounting pages with `struct Page` and other pages with a
different type name. So as far as I can see, this patch is OK for now.

Regards,
Boqun

> Alice

