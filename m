Return-Path: <linux-kernel+bounces-385921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526269B3D29
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31191F22D95
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839DF20650F;
	Mon, 28 Oct 2024 21:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4kWMHt1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F8205E1B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152126; cv=none; b=X6X8QfnECMw1VLZ72Zb/Ocjh9bz9SJ2f+eCtUjkTk0A0aVlP+ZUL6C8BrJCQ0EPlnzn/h+fRG28IreG6J7K4U0xZlLSk9rRyLcUQ7znHvT8Agq2ynJciBoJSzI9qIxi0Je2+JheZWX7jgPMgToglzwzXrGe+FZkhpsABzUcmJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152126; c=relaxed/simple;
	bh=DHx3V9c6d7RzA8Hica7IwbiE0hndkhK3ioMyo+uODqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLbHrwvDdAZt1TAH/Jc8eCkTWLo1LkiFEkhyd8TghUvsCy2+AvS6vEuqtm+T7alH38ls/vEhTLtZ+RCCg9kCKsEgVj35OSih8HWWzqMag2zCE04kwuSyHXrXJl2ZKbQlr0AEW9QODs1q1dh2KKAttFWoxrrmsxiSZkAoUc1B/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4kWMHt1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730152123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8f6rNRcHbHfSirLmOVvnWqIPco4XSliHtz6q5ZmdDI=;
	b=G4kWMHt1uUGwyhBVMt8xLFwXugTsYoBOwNN0aZyW2xqzyIYhJ+ghCz8hPyyjqRDkAEoLMR
	TtwbvuXOnYUfzSYUR/Md3TlPLQnrsfll+T3TxXojmBrdo4Sg8tRP/0mQ1EEv7/DqaALZu9
	yTFylR3PPc93F4P91tRBNxKPobbGVw8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-M30AHQ37OOqJexREAoKPCA-1; Mon,
 28 Oct 2024 17:48:38 -0400
X-MC-Unique: M30AHQ37OOqJexREAoKPCA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B31C1955EEA;
	Mon, 28 Oct 2024 21:48:36 +0000 (UTC)
Received: from redhat.com (unknown [10.22.80.130])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E345819560AA;
	Mon, 28 Oct 2024 21:48:35 +0000 (UTC)
Received: from fche by redhat.com with local (Exim 4.94.2)
	(envelope-from <fche@redhat.com>)
	id 1t5XbF-0006m0-AC; Mon, 28 Oct 2024 17:48:33 -0400
Date: Mon, 28 Oct 2024 17:48:33 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Francesco Nigro <fnigro@redhat.com>,
	Aaron Merey <amerey@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1 perf-tools-next] perf probe: Fix retrieval of source
 files from a debuginfod server
Message-ID: <20241028214833.GB25044@redhat.com>
References: <ZyACsIFUETsr7-09@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyACsIFUETsr7-09@x1>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi -

> -		if (!get_source_from_debuginfod(raw_path, sbuild_id, new_path))
> +		char prefixed_raw_path[PATH_MAX];
> +
> +		path__join(prefixed_raw_path, sizeof(prefixed_raw_path), comp_dir, raw_path);
> +
> +		if (!get_source_from_debuginfod(prefixed_raw_path, sbuild_id, n
ew_path))

lgtm!

- FChE


