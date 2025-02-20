Return-Path: <linux-kernel+bounces-524464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BB0A3E36A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2616117BE97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1073214235;
	Thu, 20 Feb 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHNxAt9C"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF46721420C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074931; cv=none; b=YcliU1p98n0RgKUbS44aqBlvVOw6OqiWNjth+2HMLPx6ovAGQcQM0bz1sqrBE/el1uXNoPkHUIY+0K6QkT79i8UVGMDIEhV2EaeVwvP6IlI02nnRYrC0Jdxx739Iba0fiBl998r+lOwDBvdcliXWMVkKooLfbJYF0rZ6i9FAi7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074931; c=relaxed/simple;
	bh=D53WxB+5XGbLoWd50Ahi6aTeZn7Ht74o0ERsJkFY5B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBBej3GsthcpUpcsgRKBJN9vToIsAs/jcQz9w2ANVGhmMKk0tI8ZOULZFvb03Xbat8RLLu65AUBu26s8k8JXpmKjoeikc5Xy8G4W4nqHrbwctuPSycjO1eWE5WDC9PfA79QqBJVHLyVM9GtoLrZILzaxxKrcZtw6u1ADvmDeWtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tHNxAt9C; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22117c396baso7695ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740074929; x=1740679729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D53WxB+5XGbLoWd50Ahi6aTeZn7Ht74o0ERsJkFY5B4=;
        b=tHNxAt9CS77Pt2+tdmEvRkzIj4drq3QAK9GIIJchikgp/FgaPZPRjTJFrvir+svepX
         nrB7YRaik7VRIU6kW4PE8MqQianYl5wb9UzDb3+hBzmu1mHVM8F6ixyBWOM3D1g75L5k
         WIjiyPn6b/+tRHZAFDJ1YFUyz/n8Z0vJRL2A00tnWecuXBX02gJldYP+0o19JSwKHlBx
         jyptbrTUa4ztXO7bCG/g1/0ChK02c9PfOHD2wiRHXamRv8/T5RmPacXUgU38pX7e9dIX
         OAfM4u0YY24NhddV1jCjgKvC0m0Pgl+Wi58ER547FeGI+ktLMcpe+SuiI96sfrMwnIGF
         HvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074929; x=1740679729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D53WxB+5XGbLoWd50Ahi6aTeZn7Ht74o0ERsJkFY5B4=;
        b=Yt/Jm26HsyurTmtxo9ayplU1w+q294vs5ABvF6Dba0h1FOq1eT/npDLUweM0oDCPos
         uR4ykzdrn7HEdxYO4nOAAvqyOmsqFxQUYp0R7rJRzqhwPracTrEyDBjPzD9RtTTfE37R
         4faut+43jLpWnaM+jszic9pUUzta4CcVkSiJMu6z5Q5l35EsVegkV5gSmPIlZ9zaQHuB
         bkeuHkEYpH8/3IkxoBnFP5rn0jzWuJAbi6UuiV+4gwtxo2gl2rkgiriGNzuxYztCHBgB
         Zq+P8YcNO/gWLWSh/gcsZVpUVCJqSPpOnUKeWxbqVM8YuftF2dQfeG25+XoFUSmcE2QZ
         SgxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6o5aX97BvLgDohlDqIFy++lb2IQwgvN/nyoPHL/MqSQQtV9TUfAxmp4TKmIgtQxNq7x/Jyy4aGLvZ0bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpaUlrfqVsDyIPt/95te1seBOGsB6DN998E9GehwKHoTVYyzgz
	CoTp4UWd3VCT69iRPTCFFFodVNHJNC/i1EthfDeD8MlfMnh73PxmhXJrYVEMNNqDNs5pXrJbRIE
	vy6smWDCm4QgkYv8BJLVaEm1l2Z877tZuQ2hI
X-Gm-Gg: ASbGncs6Ea8HLfawH7k3xfprJBjvhD4N8VczdkL2cOtNgx9E7Vovv8XJHZOM1fTz4N5
	XXv05p1Squ7dIZu1g2m+FgZoOHqtBC1bkmspIfFj5fo+4KbpBpSKShCxJq2CI/V4aaOc7YtPkV5
	U6ZpUFOLxJH2275CRACZvcyMlMBjU=
X-Google-Smtp-Source: AGHT+IGZYPDV28Cz7sYINJpTnmjw8EhukaY1/WmWGcdUtzSTAPhvLJwj66QqkFOK0m59IebD7nMgwWPPoi4mjkkZ9So=
X-Received: by 2002:a17:902:d584:b0:212:26e:1b46 with SMTP id
 d9443c01a7336-2218ffb83a8mr3053025ad.23.1740074928718; Thu, 20 Feb 2025
 10:08:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
 <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
 <6e356431-5ac9-4363-b876-78a69ae7622a@lucifer.local> <4aa97b5c-3ddc-442b-8ec9-cc43ebe9e599@redhat.com>
 <b0a95f2c-093c-45fd-b4a2-2ba5cbc37e2c@lucifer.local> <387f3516-99f2-41e9-967e-4b051a8d21b8@redhat.com>
 <72e044ba-64af-49c0-8b87-ead508654fb7@lucifer.local> <4f5a9c19-9bdd-47eb-bb14-205e3dcced90@redhat.com>
 <1e959451-2534-44b7-bf62-bc75305048fe@lucifer.local> <bd4597b5-2da2-484c-9410-384e04336a9d@redhat.com>
 <31a007c0-884f-495d-ba27-08e3e0dd767d@lucifer.local> <CAJuCfpHpchh0CzEgh5CKmRLwpscBLx32A-mGi4eudpir1wm=cQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHpchh0CzEgh5CKmRLwpscBLx32A-mGi4eudpir1wm=cQ@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 20 Feb 2025 10:08:36 -0800
X-Gm-Features: AWEUYZldDtJoTDPcjQKD0pHhJ973ZEAcjadmBHGExUTRQr9Y3pOVfjnjWolS78o
Message-ID: <CAC_TJvd2Y-EnavZkt5_nQUXmRpjo8AYMu6rND7eMUwXn27ab0A@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem mappings
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 8:22=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Feb 20, 2025 at 5:18=E2=80=AFAM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 01:44:20PM +0100, David Hildenbrand wrote:
> > > On 20.02.25 11:15, Lorenzo Stoakes wrote:
> > > > On Thu, Feb 20, 2025 at 11:03:02AM +0100, David Hildenbrand wrote:
> > > > > > > Your conclusion is 'did not participate with upstream'; I don=
't agree with
> > > > > > > that. But maybe you and Kalesh have a history on that that le=
t's you react
> > > > > > > on his questions IMHO more emotionally than it should have be=
en.
> > > > > >
> > > > > > This is wholly unfair, I have been very reasonable in response =
to this
> > > > > > thread. I have offered to find solutions, I have tried to under=
stand the
> > > > > > problem in spite of having gone to great lengths to try to disc=
uss the
> > > > > > limitations of the proposed approach in every venue I possibly =
could.
> > > > > >
> > > > > > I go out of my way to deal professionally and objectively with =
what is
> > > > > > presented. Nothing here is emotional. So I'd ask that you pleas=
e abstain
> > > > > > from making commentary like this which has no basis.
> > > > >
> > > > > I appreciate everything you write below. But this request is just
> > > > > impossible. I will keep raising my opinion and misunderstandings =
will
> > > > > happen.
> > > >
> > > > Well I wouldn't ask you not to express your opinion David, you know=
 I respect
> > > > and like you, and by all means push back hard or call out what you =
think is bad
> > > > behaviour :)
> > > >
> > > > I just meant to say, in my view, that there was no basis, but I app=
reciate
> > > > miscommunications happen.
> > > > > So apologies if I came off as being difficult or rude, it actuall=
y
> > > wasn't
> > > > intended. And to re-emphasise - I have zero personal issue with any=
body in this
> > > > thread whatsoever!
> > >
> > > It sounded to me like you were trying to defend your work (again, IMH=
O too
> > > emotionally, and I might have completely misinterpreted that) and slo=
wly
> > > switching to "friendly fire" (towards me). Apologies from my side if =
I
> > > completely misunderstood/misinterpreted that.
> >
> > Right this was not at all my intent, sorry if it seemed that way. I may=
 well
> > have communicated terribly, so apologies on my side too.

Hi everyone,

Thank you for all the discussion.

I don't find any personal issues with the communication in this
thread, but I appreciate David being the object voice of reason.

I understand it can be frustrating since you have made many efforts to
communicate these tradeoffs. Unfortunately these issues were not known
for the file-backed ELF guard regions for my particular use case.

>
> Sorry for being late to the party. Was sick for a couple of days.
> Lorenzo is right, there was a breakdown in communication at Google and
> he has all the rights to be upset. The issue with obfuscators should
> have been communicated once it was discovered. I was in regular
> discussions with Lorenzo but wasn't directly involved with this
> particular project and wasn't aware or did not realize that the
> obfuscator issue renders guards unusable for this usecase. My
> apologies, I should have asked more questions about it. I suspect
> Lorenzo would have implemented this anyway...
>

Suren's use case is different from mine and this design fits perfectly
for anon guard regions from the allocator. :)

So I think in conclusion, these aren't VMAs and shouldn't be treated
as such; we will advertise them from pagemap for those who need to
know.

-- Kalesh


> To make guard regions work for this usecase, first we (Android) need
> to abstract /proc/pid/maps accesses. Only then we can use additional
> interfaces like /proc/pid/pagemaps to obtain guard region information.
> I'll start figuring out what it takes to insert such an abstraction.
> Thanks,
> Suren.
>
>
> >
> > >
> > > To recap: what we have upstream is great; you did a great job. Yes, t=
he
> > > mechanism has its drawbacks, but that's just part of the design.
> >
> > Thanks :)
> >
> > >
> > > Some people maybe have wrong expectations, maybe there were
> > > misunderstandings, or maybe there are requirements that only now pop =
up;
> > > it's sometimes unavoidable, and that's ok.
> > >
> > > We can try to document it better (and I was trying to find clues why =
people
> > > might be mislead), and see if/how we could sort out these requirement=
s. But
> > > we can likely not make it perfect in any possible way (I'm sure there=
 are
> > > plenty of use cases where what we currently have is more than suffici=
ent).
> >
> > Sure and I"m very open to adding a documentation page for guard regions=
, in
> > fact was considering this very thing recently. I already added man page=
s
> > but be good to be able to go into more depth.
> >
> > >
> > > > > I just want to find the best way forward, technically and am will=
ing to
> > > do
> > > > whatever work is required to make the guard region implementation a=
s good as it
> > > > possibly can be.
> > > >
> > > > >
> > > > > Note that the whole "Honestly David you and the naming. .." thing=
 could have
> > > > > been written as "I don't think it's a naming problem."
> > > >
> > > > I feel like I _always_ get in trouble when I try to write in a 'ton=
gue-in-cheek'
> > > > style, which is what this was meant to be... so I think herein lies=
 the basis of
> > > > the miscommunication :)
> > > >
> > > > I apologise, the household is ill, which maybe affects my judgment =
in how I
> > > > write these, but in general text is a very poor medium. It was mean=
t to be said
> > > > in a jolly tone with a wink...
> > > >
> > > > I think maybe I should learn my lesson with these things, I thought=
 the ':p'
> > > > would make this clear but yeah, text, poor medium.
> > > >
> > > > Anyway apologies if this seemed disrespectful.
> > >
> > > No worries, it's hard to really make me angry, and I appreciate your
> > > openness and your apology (well, and you and your work, obviously).
> > >
> > > I'll note, though, if my memory serves me right, that nobody so far e=
ver
> > > criticized the way I communicate upstream, or even told me to abstain=
 from
> > > certain communication.
> >
> > I wish I could say the same haha, so perhaps this was a problem on my s=
ide
> > honestly. I do have a habit of being 'tongue in cheek' and failing to
> > communicate that which I did say the last time I wouldn't repeat. It is=
 not
> > intended, I promise.
> >
> > As the abstain, was more a British turn of phrase, meaning to say - I
> > dispute the claim that this is an emotional thing and please don't say =
this
> > if it isn't so.
> >
> > But I understand that of course, you may have interpreted it as so, due=
 to
> > my having failed to communicate it well.
> >
> > Again, I must say, text remains replete with possibilities for
> > miscommunication, misunderstanding and it can so often be difficult to
> > communicate one's intent.
> >
> > But again of course, I apologise if I overstepped the line in any way!
> >
> > >
> > > That probably hurt most, now that a couple of hours passed. Nothing t=
hat a
> > > couple of beers and a bit of self-reflection on my communication styl=
e can't
> > > fix ;)
> >
> > Ugh sorry, man. Not my intent. And it seems - I literally OWE YOU pints
> > now. :) we will fix this at lsf...
> >
> > Perhaps owe Kalesh some too should he be there... will budget
> > accordingly... :P
> >
> > >
> > > [...]
> > >
> > > > > > > > Yeah that's a good point, but honestly if you're reading sm=
aps that reads
> > > > > > > > the page tables, then reading /proc/$pid/pagemaps and readi=
ng page tables
> > > > > > > > TWICE that seems inefficient vs. just reading /proc/$pid/ma=
ps, then reading
> > > > > > > > /proc/$pid/pagemaps and reading page tables once.
> > > > > > >
> > > > > > > Right; I recently wished that we would have an interface to o=
btain more VMA
> > > > > > > flags without having to go through smaps
> > > > > >
> > > > > > Well maybe that lends itself to the idea of adding a whole new =
interface in
> > > > > > general...
> > > > >
> > > > > An extended "maps" interface might be reasonable, that allows for=
 exposing
> > > > > more things without walking the page tables. (e.g., flags)
> > > > >
> > > > > Maybe one could have an indicator that says "ever had guard regio=
ns in this
> > > > > mapping" without actually walking the page tables.
> > > >
> > > > Yeah this is something we've discussed before, but it's a little fr=
aught. Let's
> > > > say it was a VMA flag, in this case we'd have to make this flag 'st=
icky' and not
> > > > impact merging (easy enough) to account for splits/merges.
> > > > > The problem comes in that we would then need to acquire the VMA w=
rite
> > > lock to do
> > > > it, something we don't currently require on application of guard re=
gions.
> > >
> > > Right, and we shouldn't write-lock the mmap. We'd need some way to ju=
st
> > > atomically set such an indicator on a VMA.
> >
> > Hm yeah, could be tricky, we definitely can't manage a new field in
> > vm_area_struct, this is a very sensitive subject at the moment really w=
ith
> > Suren's work with VMAs allocated via SLAB_TYPESAFE_BY_RCU, putting the =
lock
> > into the VMA and the alignment requirements.
> >
> > Not sure what precedent we'd have with atomic setting of a VMA flag for
> > this... could be tricky.
> >
> > >
> > > I'll also note that it might be helpful for smallish region, but espe=
cially
> > > for large ones (including when they are split and the indicator is wr=
ong),
> > > it's less helpful. I don't have to tell you about the VMA merging
> > > implications, probably it would be like VM_SOFTDIRTY handling :)
> >
> > Yeah indeed now we've simplified merging a lot of possibilities emerge,
> > this is one!
> >
> > >
> > > >
> > > > We'd also have to make sure nothing else makes any assumptions abou=
t VMA flags
> > > > implying differences in VMAs in this one instance (though we do alr=
eady do this
> > > > for VM_SOFTDIRTY).
> > > >
> > > > I saw this as possibly something like VM_MAYBE_GUARD_REGIONS or som=
ething.
> > >
> > > Yes.
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >
> >
> > Best, Lorenzo

