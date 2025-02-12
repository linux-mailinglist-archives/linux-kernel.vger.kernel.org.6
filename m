Return-Path: <linux-kernel+bounces-511105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C0A325EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2769D167746
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52BB20C48A;
	Wed, 12 Feb 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YwLO0XoO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345D20B7FD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363861; cv=none; b=GyT02TrYWUuMLHe+cVogv9XJgnQGXtl/AKIY6xxukOZWbNiElOif8HwNt2kWn6WH4f0tXZ+AbreId8LGRbPovD3NeBXRRdp5Khl3rD+/LwI7UcBMNifjgU5wb943HcurtnEGobC1wJBzmtZ5ED+qLOXcStxhvIBKDD8DGErYuMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363861; c=relaxed/simple;
	bh=4vF4v9ob3Qt/mW/L63qd6/SAxzb9yktu841ziiVlM6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ir405almgQjaRci2BfUm+pA4iZYAId8GfMic3J4RBzXJs6fLT0CccotfNjWiQ4cVLnm2glHIIEoL6Wesx3xXqjgLP64tjrhJIoaGajxjY6XlmZ3WGl8+7pDUssIZJpCdUialtXi+527JaOsk/2GeF+oAjY+bG5O0lVRlmJLN8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YwLO0XoO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4vF4v9ob3Qt/mW/L63qd6/SAxzb9yktu841ziiVlM6k=; b=YwLO0XoOeeK4Q6urL4urw1+a4/
	4foenamCUfufzAyjm9joxAHlnYNT+g1Q2XcwX3F9AhYZIvpbtLTtmambkcsy0c/c/llLN/5I9UtyD
	XFZr2pUUhB3X6jIGSvd437i28qcS7llZEJE/oxwP2jZA1IVWwTfYMpMpcFSxMeB44YCcWG6+Rktpt
	4oWBQx8xP1WXJVDC5EmgR7e81Kjs9FNDOsk4kon2dZ12AijEpZq0rPALLJk42NCW5uF+NIT/Ke1cu
	esXdcsizifIA0VNrJgAGIYxg31306Ad6ea4n5kDBidWtgBnhmowzHXbjXKdTP9Odo6CKh8O48kQ48
	88OpQMFg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiByo-00000004mqO-1xGa;
	Wed, 12 Feb 2025 12:37:11 +0000
Date: Wed, 12 Feb 2025 12:36:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Liu Ye <liuye@kylinos.cn>
Cc: brauner@kernel.org, dhowells@redhat.com, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/mm.h: Write folio->_flags_1 & 0xff as a macro
 definition
Message-ID: <Z6yV1hZDn9Lbh6XG@casper.infradead.org>
References: <20250212025843.80283-1-liuye@kylinos.cn>
 <20250212025843.80283-3-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212025843.80283-3-liuye@kylinos.cn>

On Wed, Feb 12, 2025 at 10:58:43AM +0800, Liu Ye wrote:
> There are multiple locations in mm.h where (folio->_flags_1 & 0xff) is
> used. Write it as a macro definition to improve the readability and
> maintainability of the code.

No.

