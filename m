Return-Path: <linux-kernel+bounces-200027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3848FA96E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310EC1F23A59
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796F613D516;
	Tue,  4 Jun 2024 04:50:36 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5479FE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717476636; cv=none; b=pDge+IoxjAvQPwvK3KNxCkmj3hOOA+7Q0y7a6b9+gteuBRIgIdjhowGkRltzpBXGB4rEmRUFYFFPBOtySVTMjW8OFglsp4jK2oOfsX7qtJO3fiIelMlkKByaT8jSTPMNnUTXjzyJ8WmPH8sY6g/YTYuV2lR4KXSbgLykeJLml00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717476636; c=relaxed/simple;
	bh=JXAVo7JPxoRmBdKOx1Ae8EBGrOZ45EPRVBDGB91vwlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUc+Mfd7N7oZnkro49rxZov7cl2dWUDDVUQ1hWXk1FL+Fb/x4Nmwr3/8ZhpFyqcdjxgSODUVqbpQGYgWMuvdXaj8wlLHiseuNY5Dkgq3apHYBlzk7XYValx28y/nFRfbTMgaxDLlOKiOjztqfsabz7SkDzrs9S/ZhcfMj7pJlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E7F9B68D12; Tue,  4 Jun 2024 06:50:30 +0200 (CEST)
Date: Tue, 4 Jun 2024 06:50:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Terry Tritton <terry.tritton@linaro.org>
Cc: hch@lst.de, "ttritton@google.com" <ttritton@google.com>,
	edliaw@google.com, keescook@chromium.org,
	linux-kernel@vger.kernel.org
Subject: Re: Change in splice() behaviour after 5.10?
Message-ID: <20240604045030.GA29276@lst.de>
References: <CABeuJB1RP8wty0AObsmw+FCWMNyAmrutL-ZXy9ZwnZ8oK1iGSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeuJB1RP8wty0AObsmw+FCWMNyAmrutL-ZXy9ZwnZ8oK1iGSg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 03, 2024 at 10:59:15AM +0100, Terry Tritton wrote:
> Hi,
> We've found a change in behaviour while testing the splice07 LTP test.
> In versions before 5.10 the test will hang on certain combinations but after
> 5.10 the splice call will return.
> I bisected the change to the following commit:
>     36e2c7421f02a22f71c9283e55fdb672a9eb58e7
>     fs: don't allow splice read/write without explicit ops
> 
> There has been some discussion on the LTP github page already:
>     https://github.com/linux-test-project/ltp/issues/1156

In that case the return probably is an error because epoll doesn't
support read_iter/write_iter and thus completely expected.

If the underlying bug hasn't been fix in the mean time that probably
means it will be back if Jens' conversion of all misc file operations
to the iter based ones every gets merged.

If you are interested more in this please discuss it on the relevant
mailing lists instead of in private mail.


