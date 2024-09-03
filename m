Return-Path: <linux-kernel+bounces-312827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D7969C25
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D4BB24AF8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9181AD259;
	Tue,  3 Sep 2024 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="QxUEuvvI"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB81C987C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363508; cv=none; b=KyY0cn2Y07mHjNVTELaluAnjJeBPQqmV0kMJwqbxUXFeck2EBzjGTNXqpGM14zXgdUtsjtwVeuj2gGbVcFdoKDBT6iet7l0LKTck9MmExxIG9AFXWiOR/Z2r12bc3iHGcrZZkX9Yb7M7bviy4bTJBU8LzyoGsGv4NDzcfo+NH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363508; c=relaxed/simple;
	bh=H7xQXb9uIYfTdGgjIPR8jPDXI/1f9j1Zczxnt7KO+C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZ20xb2uQ+lQghczOKPNP/RiI9meO+RuuX/6NMmScfqEPOgIA8Lff0/6YtbZANAlK8Z0BGSHm/ulfMvXampaJ+hO/XoqqI5Thpe/n3PkrCfLW/kwBzfpOFNUuW1oFSxpnGWRjcnxpw4iyogmTAFfrt/vtvGoZuUTZMUd023JAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=QxUEuvvI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 483BboFC025940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 07:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725363473; bh=SWh9mkHKw8WQ6jQIGbEdZnZ/6yH6GD/cIq1aKAhLnUE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=QxUEuvvIqChKGC16zAqCbU6WGby+e0Wk6EIqI+Z22JauuPYWSQegVEbTy+Hzas0/F
	 FUNKS42MCoBZ74//umPRThl0sofc593WIvOuvCexs9YzgTarGaMcSZrY+xbrrQ8zZB
	 gsccUcYG0YaYxRp0+tS0rXC08Ouet/hQzyLOAii/s+1twmllt9b2n4rRb9IkLNMHfL
	 Ld4/+DTCFKWWmR6sL5ZUm2oJ8wxKH6vVj07QyiGTLo5nlQ6HRjUh4WhLu/AO3xkZLx
	 SME8nWNrDfVND27FLnbXMXCRNyRJOIA6fLwx1V4WwOLZQVNfz/KKY5WLpOWUvxyi0E
	 aAB8VC7YX9cow==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 59C6415C02C4; Tue, 03 Sep 2024 07:37:50 -0400 (EDT)
Date: Tue, 3 Sep 2024 07:37:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        krisman@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        Daniel Rosenberg <drosen@google.com>, smcv@collabora.com,
        Christoph Hellwig <hch@lst.de>,
        Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: Re: [PATCH v2 3/8] ext4: Use utf8_check_strict_name helper
Message-ID: <20240903113750.GB1002375@mit.edu>
References: <20240902225511.757831-1-andrealmeid@igalia.com>
 <20240902225511.757831-4-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902225511.757831-4-andrealmeid@igalia.com>

On Mon, Sep 02, 2024 at 07:55:05PM -0300, André Almeida wrote:
> Use the helper function to check the requeriments for casefold
> directories using strict enconding.
> 
> Suggested-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

Acked-by: Theodore Ts'o <tytso@mit.edu>

