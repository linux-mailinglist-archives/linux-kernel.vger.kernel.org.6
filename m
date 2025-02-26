Return-Path: <linux-kernel+bounces-534407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98301A4669D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A22417E36C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34D21CC5B;
	Wed, 26 Feb 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfYmzpHJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D221ADDB;
	Wed, 26 Feb 2025 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586652; cv=none; b=Uk+VOOpxMcRZaYHtj4RvnDsi3GMf0CYcdKWSg56yK7qgCYPgxum+T+qqoxHVCIR+TMyBcn4kOin2SB9zbRRVaDJEOB4cLpe3u489sTMZFz9dDI5QyTfVx0tNH/Q2BKAV3ngDM6LEIh3eMVxQlzI70KU/66LGz5iwMOT3pj7aTzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586652; c=relaxed/simple;
	bh=hTDll0v44fX4PzBDNzX/XDQI/T4ea8XLw46b2NQU8Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAIgEy09ipUitZjJ4ju/f+YDeW7PV2TUgHBhFSHdJl7StA9m+Y9bxjD7+6s2PckgagzzbjG1MBomJ3Kuh0O2rBn8Ccy5nC45ra5i7Rj442kP8mdF3vfzdOQs5opOsTCg9si3sDE9KOgfFmKk3/DnB1IL8rGZEbpHI6q9ocKXgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfYmzpHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD82BC4CED6;
	Wed, 26 Feb 2025 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740586652;
	bh=hTDll0v44fX4PzBDNzX/XDQI/T4ea8XLw46b2NQU8Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfYmzpHJx9xKYxDxXxz6F9KACvPpNPyeyEnDO9vWos6F335nFfvdRB6I7GscMvB5w
	 wsOpFGOVsjoxIw26RKUQPZLmzdr7iUO9K1BpSJMrKf6FYwEDMxHdihKvHeqC6oxVVp
	 LQNXnVwKPE/ArrjdryToY5fEkzcO/goFD9956nSrqlOtyY8eBCDLvB9tzfJe7rk5m+
	 LjbcONHfFViZdN5/NB2PPfcnRdWC+zAucOAd/fWDZpTmOW6ZIegCn2opd+6CSh3GmT
	 M+ixpoQfd1NPfeyZJ6h6MzWGWKr7KfcWI80REoFdHTg8SyXwUFSVlyc1IEdoVxMKGy
	 5JONwROT2rEvg==
Date: Wed, 26 Feb 2025 17:17:29 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 13/13] rust: hrtimer: add maintainer entry
Message-ID: <Z78-mVAHdSq1zbJr@localhost.localdomain>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <20250224-hrtimer-v3-v6-12-rc2-v9-13-5bd3bf0ce6cc@kernel.org>
 <Z7yT5XU5gAm0ZCZD@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7yT5XU5gAm0ZCZD@Mac.home>

Le Mon, Feb 24, 2025 at 07:44:37AM -0800, Boqun Feng a écrit :
> On Mon, Feb 24, 2025 at 01:03:47PM +0100, Andreas Hindborg wrote:
> > Add Andreas Hindborg as maintainer for Rust `hrtimer` abstractions. Also
> > add Boqun Feng as reviewer.
> > 
> > Acked-by: Boqun Feng <boqun.feng@gmail.com>
> > Acked-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Frederic, since you've reviewed the series, and we certainly need your
> expertise here, do you want to be an reviewer in this maintainer entry
> (to watch how we are doing maybe ;-))?

Yes indeed! Please include me as a reviewer!

Thanks!

